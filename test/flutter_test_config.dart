import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Load real fonts only when explicitly rendering screenshots for the report.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  if (!const bool.fromEnvironment('CAPTURE_REPORT')) {
    await testMain();
    return;
  }
  TestWidgetsFlutterBinding.ensureInitialized();
  final config = jsonDecode(
    File('.dart_tool/package_config.json').readAsStringSync(),
  ) as Map<String, dynamic>;
  final packages = config['packages'] as List<dynamic>;
  final flutter = packages.cast<Map<String, dynamic>>().firstWhere(
    (p) => p['name'] == 'flutter',
  );
  final packageConfigUri = File('.dart_tool/package_config.json').absolute.uri;
  final root = Directory(
    packageConfigUri.resolve(flutter['rootUri'] as String).toFilePath(),
  ).parent.parent.path;
  final loader = FontLoader('Roboto');
  for (final font in [
    ('roboto-regular.ttf', 'Roboto/Roboto-Regular.ttf'),
    ('roboto-medium.ttf', 'Roboto/Roboto-Medium.ttf'),
    ('roboto-bold.ttf', 'Roboto/Roboto-Bold.ttf'),
  ]) {
    loader.addFont(
      Future.value(
        ByteData.sublistView(
          _sdkFont(root, font.$1, font.$2).readAsBytesSync(),
        ),
      ),
    );
  }
  await loader.load();
  final icons = FontLoader('MaterialIcons')
    ..addFont(
      Future.value(
        ByteData.sublistView(
          _sdkFont(
            root,
            'materialicons-regular.otf',
            'MaterialIcons-Regular.otf',
          ).readAsBytesSync(),
        ),
      ),
    );
  await icons.load();
  await testMain();
}

File _sdkFont(String root, String materialName, String devToolsName) {
  final cached = File('$root/bin/cache/artifacts/material_fonts/$materialName');
  if (cached.existsSync()) return cached;
  return File(
    '$root/bin/cache/dart-sdk/bin/resources/devtools/assets/fonts/$devToolsName',
  );
}
