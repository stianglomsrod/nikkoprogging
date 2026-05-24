import 'package:flutter/material.dart';

class BottomActionArea extends StatelessWidget {
  const BottomActionArea({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 220),
      child: child,
    );
  }
}

class BottomActionGroup extends StatelessWidget {
  const BottomActionGroup({
    super.key,
    required this.groupKey,
    required this.children,
  });

  final Key groupKey;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: groupKey,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }
}
