import 'package:flutter/material.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({
    super.key,
    required this.index,
    required this.onChanged,
  });
  final int index;
  final ValueChanged<int> onChanged;
  @override
  Widget build(BuildContext context) => NavigationBar(
    selectedIndex: index,
    onDestinationSelected: onChanged,
    destinations: const [
      NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Головна'),
      NavigationDestination(icon: Icon(Icons.person_outline), label: 'Профіль'),
    ],
  );
}
