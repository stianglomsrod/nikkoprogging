import 'package:flutter/material.dart';

class CompanionFigure extends StatelessWidget {
  const CompanionFigure({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Center(
      child: Container(
        width: 260,
        height: 260,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: colors.shadow.withValues(alpha: 0.22),
              blurRadius: 32,
              offset: const Offset(0, 14),
            ),
          ],
        ),
        child: Image.asset(
          'assets/figures/companion_figur.png',
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}
