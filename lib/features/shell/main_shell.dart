import 'package:flutter/material.dart';

import '../../core/data/demo_session.dart';
import '../../core/widgets/app_navigation_bar.dart';
import '../auth/login_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  final session = DemoSession();
  int index = 0;

  @override
  void dispose() {
    session.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: session,
    builder: (context, _) => Scaffold(
      appBar: AppBar(
        title: Text(
          index == 0 ? 'Журнал обслуговування авто' : 'Профіль',
          maxLines: 2,
          style: const TextStyle(fontSize: 20, height: 1.15),
        ),
        actions: [
          if (index == 1)
            TextButton.icon(
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (_) => false,
              ),
              icon: const Icon(Icons.logout, size: 20),
              label: const Text('Вийти з акаунта'),
            ),
        ],
      ),
      body: index == 0
          ? HomeScreen(session: session)
          : ProfileScreen(session: session),
      bottomNavigationBar: AppNavigationBar(
        index: index,
        onChanged: (value) => setState(() => index = value),
      ),
    ),
  );
}
