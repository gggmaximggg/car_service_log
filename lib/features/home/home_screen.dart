import 'package:flutter/material.dart';

import '../../core/data/demo_data.dart';
import '../../core/data/demo_session.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/screen_body.dart';
import '../../core/widgets/ui_feedback.dart';

/// S-04. Static laboratory data and quick actions with visible UI feedback.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.session});
  final DemoSession session;

  @override
  Widget build(BuildContext context) => ScreenBody(
    children: [
      Text(
        'Вітаємо, ${session.name}!',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      const SizedBox(height: 6),
      const Text(
        'Ваш автомобіль під контролем',
        style: TextStyle(color: AppColors.muted),
      ),
      const SectionTitle('Ваш автомобіль'),
      AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DemoData.carName,
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            const Text(
              DemoData.carDescription,
              style: TextStyle(color: AppColors.muted),
            ),
            const SizedBox(height: 16),
            const Text(
              DemoData.mileage,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      const AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Загальні витрати', style: TextStyle(color: AppColors.muted)),
            SizedBox(height: 8),
            Text(
              DemoData.expenses,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'За весь час обслуговування',
              style: TextStyle(color: AppColors.muted),
            ),
          ],
        ),
      ),
      const SectionTitle('Швидкі дії'),
      AppButton(
        label: 'Додати запис',
        icon: Icons.add,
        onPressed: () =>
            showMessage(context, 'Демонстраційна дія: додавання запису'),
      ),
      const SizedBox(height: 12),
      AppButton(
        label: 'Оновити пробіг',
        icon: Icons.speed_outlined,
        outlined: true,
        onPressed: () =>
            showMessage(context, 'Демонстраційна дія: оновлення пробігу'),
      ),
      const SectionTitle('Останні записи'),
      for (final record in DemoData.recentServices)
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  record.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${record.date}  •  ${record.mileage}',
                  style: const TextStyle(color: AppColors.muted),
                ),
                const SizedBox(height: 8),
                Text(
                  record.cost,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
    ],
  );
}
