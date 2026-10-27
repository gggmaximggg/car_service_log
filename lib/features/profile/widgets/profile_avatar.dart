import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) => CircleAvatar(
    radius: 42,
    backgroundColor: AppColors.tint,
    child: Text(
      name.isEmpty ? 'М' : name.characters.first.toUpperCase(),
      style: const TextStyle(fontSize: 34, color: AppColors.primary),
    ),
  );
}
