import 'package:flutter/material.dart';

import '../../core/data/demo_session.dart';
import '../../core/data/demo_data.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/screen_body.dart';
import '../../core/widgets/ui_feedback.dart';
import 'edit_profile_screen.dart';
import 'change_password_screen.dart';
import 'widgets/profile_avatar.dart';

/// S-12. Logout is in the upper right corner, supplied by MainShell.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.session});
  final DemoSession session;
  @override
  Widget build(BuildContext context) => ScreenBody(
    children: [
      const SizedBox(height: 16),
      Center(child: ProfileAvatar(name: session.name)),
      const SizedBox(height: 16),
      Text(
        session.name,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineSmall
            ?.copyWith(fontWeight: FontWeight.w600),
      ),
      const SizedBox(height: 6),
      Text(
        session.email,
        textAlign: TextAlign.center,
        style: const TextStyle(color: AppColors.muted),
      ),
      const SizedBox(height: 28),
      AppCard(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(child: _ProfileStat(DemoData.carCount, 'Автомобілі')),
            Expanded(child: _ProfileStat(DemoData.recordCount, 'Записів ТО')),
          ],
        ),
      ),
      const SectionTitle('Обліковий запис'),
      AppCard(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              leading: const Icon(
                Icons.edit_outlined,
                color: AppColors.primary,
              ),
              title: const Text('Редагувати профіль'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () =>
                  openScreen(context, EditProfileScreen(session: session)),
            ),
            const Divider(height: 1),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              leading: const Icon(Icons.lock_outline, color: AppColors.primary),
              title: const Text('Змінити пароль'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => openScreen(context, const ChangePasswordScreen()),
            ),
          ],
        ),
      ),
      const SizedBox(height: 32),
      const Text(
        'Журнал обслуговування авто\nВерсія 1.0.0',
        textAlign: TextAlign.center,
        style: TextStyle(color: AppColors.muted, height: 1.6),
      ),
    ],
  );
}

class _ProfileStat extends StatelessWidget {
  const _ProfileStat(this.value, this.label);
  final String value, label;
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(
        value,
        style: Theme.of(context).textTheme.headlineSmall
            ?.copyWith(color: AppColors.primary),
      ),
      Text(label, style: const TextStyle(color: AppColors.muted)),
    ],
  );
}
