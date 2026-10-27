import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/theme/app_theme.dart';
import 'features/auth/login_screen.dart';

class CarServiceApp extends StatelessWidget {
  const CarServiceApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Журнал обслуговування авто',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.light,
    locale: const Locale('uk'),
    supportedLocales: const [Locale('uk')],
    localizationsDelegates: GlobalMaterialLocalizations.delegates,
    home: const LoginScreen(),
  );
}
