import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.outlined = false,
  });
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool outlined;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: outlined
        ? OutlinedButton.icon(
            onPressed: onPressed,
            icon: icon == null ? null : Icon(icon),
            label: Text(label),
          )
        : FilledButton.icon(
            onPressed: onPressed,
            icon: icon == null ? null : Icon(icon),
            label: Text(label),
          ),
  );
}
