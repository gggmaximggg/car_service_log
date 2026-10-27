import 'package:flutter/material.dart';

import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_text_field.dart';
import 'widgets/auth_layout.dart';

/// S-02.
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) => AuthLayout(
    title: 'Реєстрація',
    subtitle: 'Створіть акаунт для свого автожурналу',
    children: [
      const AppTextField(label: 'Ім’я', icon: Icons.person_outline),
      const AppTextField(
        label: 'Електронна пошта',
        keyboardType: TextInputType.emailAddress,
        icon: Icons.mail_outline,
      ),
      const AppTextField(label: 'Пароль', password: true),
      const AppTextField(label: 'Підтвердження пароля', password: true),
      AppButton(
        label: 'Зареєструватися',
        onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
      ),
      const SizedBox(height: 12),
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Уже є акаунт? Увійти'),
      ),
    ],
  );
}
