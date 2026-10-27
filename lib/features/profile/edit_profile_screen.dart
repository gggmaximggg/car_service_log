import 'package:flutter/material.dart';

import '../../core/data/demo_session.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/screen_body.dart';
import '../../core/widgets/ui_feedback.dart';
import 'widgets/profile_avatar.dart';

/// S-13. Edits exist only until logout/restart.
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.session});
  final DemoSession session;
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final form = GlobalKey<FormState>();
  late final name = TextEditingController(text: widget.session.name);
  late final email = TextEditingController(text: widget.session.email);
  @override
  void dispose() {
    name.dispose();
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Редагування профілю')),
    body: Form(
      key: form,
      child: ScreenBody(
        children: [
          const SizedBox(height: 16),
          Center(child: ProfileAvatar(name: name.text)),
          const SizedBox(height: 20),
          AppTextField(
            label: 'Ім’я',
            controller: name,
            validator: (v) =>
                v == null || v.trim().isEmpty ? 'Вкажіть ім’я' : null,
          ),
          AppTextField(
            label: 'Електронна пошта',
            controller: email,
            keyboardType: TextInputType.emailAddress,
            validator: (v) =>
                v == null ||
                    !RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(v.trim())
                ? 'Вкажіть коректну пошту'
                : null,
          ),
          const SizedBox(height: 12),
          AppButton(
            label: 'Зберегти зміни',
            onPressed: () {
              if (!form.currentState!.validate()) return;
              widget.session.updateProfile(name.text.trim(), email.text.trim());
              Navigator.pop(context);
              showMessage(context, 'Профіль оновлено в поточній демонстрації');
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
