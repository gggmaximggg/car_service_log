import 'package:flutter/material.dart';

import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/ui_feedback.dart';
import '../shell/main_shell.dart';
import 'register_screen.dart';
import 'reset_password_screen.dart';
import 'widgets/auth_layout.dart';

/// S-01. The button opens a demonstration session without authentication.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) => AuthLayout(
    back: false,
    title: 'Вхід',
    subtitle:
        'Журнал обслуговування авто\nУсе про ваш автомобіль в одному місці',
    children: [
      const AppTextField(
        label: 'Електронна пошта',
        keyboardType: TextInputType.emailAddress,
        icon: Icons.mail_outline,
      ),
      const AppTextField(
        label: 'Пароль',
        password: true,
        icon: Icons.lock_outline,
      ),
      Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () => openScreen(context, const ResetPasswordScreen()),
          child: const Text('Забули пароль?'),
        ),
      ),
      const SizedBox(height: 12),
      AppButton(
        label: 'Увійти',
        onPressed: () => Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (_) => const MainShell())),
      ),
      const SizedBox(height: 16),
      Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const Text('Ще немає акаунта?'),
          TextButton(
            onPressed: () => openScreen(context, const RegisterScreen()),
            child: const Text('Зареєструватися'),
          ),
        ],
      ),
    ],
  );
}
