import 'package:companion_app/features/home/widgets/bottom_action_area.dart';
import 'package:flutter/material.dart';

class BackgroundMusicEventView extends StatelessWidget {
  const BackgroundMusicEventView({
    super.key,
    required this.onCheckNow,
    required this.onLater,
  });

  final VoidCallback onCheckNow;
  final VoidCallback onLater;

  @override
  Widget build(BuildContext context) {
    return BottomActionGroup(
      groupKey: const ValueKey('actions-background-music-event'),
      children: [
        FilledButton(
          key: const ValueKey('background-music-check-now-button'),
          onPressed: onCheckNow,
          child: const Text('Sjekk ut nå'),
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          key: const ValueKey('background-music-later-button'),
          onPressed: onLater,
          child: const Text('Senere'),
        ),
      ],
    );
  }
}
