import 'package:flutter/material.dart';

class CompanionFigure extends StatelessWidget {
  const CompanionFigure({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Center(
      child: Container(
        width: 124,
        height: 124,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [colors.primaryContainer, colors.surfaceContainerHighest],
          ),
          boxShadow: [
            BoxShadow(
              color: colors.shadow.withValues(alpha: 0.06),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 40,
              left: 42,
              child: CircleAvatar(
                radius: 4,
                backgroundColor: colors.onPrimaryContainer,
              ),
            ),
            Positioned(
              top: 40,
              right: 42,
              child: CircleAvatar(
                radius: 4,
                backgroundColor: colors.onPrimaryContainer,
              ),
            ),
            Positioned(
              bottom: 36,
              child: Container(
                width: 30,
                height: 12,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: colors.onPrimaryContainer,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}