import 'package:flutter/material.dart';

class ScreenBody extends StatelessWidget {
  const ScreenBody({super.key, required this.children, this.padding = 20});
  final List<Widget> children;
  final double padding;
  @override
  Widget build(BuildContext context) => SafeArea(
    child: Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: ListView(
          padding: EdgeInsets.fromLTRB(padding, 12, padding, 32),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: children,
        ),
      ),
    ),
  );
}
