import 'package:flutter/material.dart';

import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/ui_feedback.dart';
import 'widgets/auth_layout.dart';

/// S-03.
class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) => AuthLayout(
    title: 'Відновлення пароля',
    subtitle: 'Вкажіть електронну пошту для відновлення доступу',
    children: [
      const AppTextField(
        label: 'Електронна пошта',
        keyboardType: TextInputType.emailAddress,
        icon: Icons.mail_outline,
      ),
      AppButton(
        label: 'Надіслати інструкції',
        onPressed: () {
          Navigator.pop(context);
          showMessage(
            context,
            'Демонстрація відновлення доступу. Лист не надсилається.',
          );
        },
      ),
      const SizedBox(height: 12),
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Повернутися до входу'),
      ),
    ],
  );
}
