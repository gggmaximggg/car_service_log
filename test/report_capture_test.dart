import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import 'widget_test.dart' show startApp, tapText;

Future<void> capture(WidgetTester tester, String name) async {
  await tester.pumpAndSettle();
  final boundary = tester.renderObject<RenderRepaintBoundary>(
    find.byKey(const ValueKey('report-capture')),
  );
  await tester.runAsync(() async {
    final image = await boundary.toImage(pixelRatio: 2);
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    final dir = Directory('docs/screenshots')..createSync(recursive: true);
    await File('${dir.path}/$name.png')
        .writeAsBytes(data!.buffer.asUint8List());
    image.dispose();
  });
  expect(tester.takeException(), isNull);
}

Future<void> back(WidgetTester tester) async {
  await tester.tap(find.byType(BackButton));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Render the seven required laboratory screens', (tester) async {
    final oldShadows = debugDisableShadows;
    debugDisableShadows = false;
    try {
      await startApp(tester);
      await capture(tester, 'S-01-login');
      await tapText(tester, 'Зареєструватися');
      await capture(tester, 'S-02-register');
      await back(tester);
      await tapText(tester, 'Забули пароль?');
      await capture(tester, 'S-03-reset-password');
      await back(tester);
      await tapText(tester, 'Увійти');
      await capture(tester, 'S-04-home');
      await tapText(tester, 'Профіль');
      await capture(tester, 'S-12-profile');
      await tapText(tester, 'Редагувати профіль');
      await capture(tester, 'S-13-edit-profile');
      await back(tester);
      await tapText(tester, 'Змінити пароль');
      await capture(tester, 'S-14-change-password');
    } finally {
      debugDisableShadows = oldShadows;
    }
  }, skip: !const bool.fromEnvironment('CAPTURE_REPORT'));
}
