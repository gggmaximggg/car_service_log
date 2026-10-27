import 'package:flutter/material.dart';

import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/screen_body.dart';
import '../../core/widgets/ui_feedback.dart';

/// S-14. Passwords are neither stored nor submitted.
class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final form = GlobalKey<FormState>();
  final password = TextEditingController();
  @override
  void dispose() {
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Зміна пароля')),
    body: Form(
      key: form,
      child: ScreenBody(
        children: [
          const SizedBox(height: 12),
          const Text('Введіть поточний пароль і придумайте новий.'),
          const SizedBox(height: 24),
          AppTextField(
            label: 'Поточний пароль',
            password: true,
            validator: (v) =>
                v == null || v.isEmpty ? 'Введіть поточний пароль' : null,
          ),
          AppTextField(
            label: 'Новий пароль',
            password: true,
            controller: password,
            validator: (v) =>
                (v?.length ?? 0) < 6 ? 'Щонайменше 6 символів' : null,
          ),
          AppTextField(
            label: 'Підтвердження нового пароля',
            password: true,
            validator: (v) =>
                v != password.text ? 'Паролі не збігаються' : null,
          ),
          const SizedBox(height: 12),
          AppButton(
            label: 'Змінити пароль',
            onPressed: () {
              if (!form.currentState!.validate()) return;
              Navigator.pop(context);
              showMessage(context, 'Зміну пароля продемонстровано');
            },
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Скасувати'),
          ),
        ],
      ),
    ),
  );
}
