import 'package:flutter/material.dart';

class HomeLayoutShell extends StatelessWidget {
  const HomeLayoutShell({
    super.key,
    required this.dialogue,
    required this.figure,
    required this.bottomActions,
  });

  final Widget dialogue;
  final Widget figure;
  final Widget bottomActions;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Align(alignment: const Alignment(0, -0.02), child: figure),
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(width: double.infinity, child: dialogue),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(width: double.infinity, child: bottomActions),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
