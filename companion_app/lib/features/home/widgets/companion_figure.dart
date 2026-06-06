import 'dart:async';

import 'package:flutter/material.dart';

enum CompanionAnimationState { idle, happy, sleep }

class CompanionFigure extends StatefulWidget {
  const CompanionFigure({
    super.key,
    this.animationState = CompanionAnimationState.idle,
  });

  final CompanionAnimationState animationState;

  @override
  State<CompanionFigure> createState() => _CompanionFigureState();
}

class _CompanionFigureState extends State<CompanionFigure> {
  static const _frameStep = Duration(milliseconds: 480);

  static const Map<CompanionAnimationState, List<String>> _animationFrames = {
    CompanionAnimationState.idle: [
      'assets/animations/companion/idle/frame_01.png',
      'assets/animations/companion/idle/frame_02.png',
      'assets/animations/companion/idle/frame_03.png',
      'assets/animations/companion/idle/frame_04.png',
      'assets/animations/companion/idle/frame_05.png',
      'assets/animations/companion/idle/frame_06.png',
    ],
    CompanionAnimationState.happy: [
      'assets/animations/companion/happy/frame_01.png',
      'assets/animations/companion/happy/frame_02.png',
      'assets/animations/companion/happy/frame_03.png',
      'assets/animations/companion/happy/frame_04.png',
      'assets/animations/companion/happy/frame_05.png',
      'assets/animations/companion/happy/frame_06.png',
    ],
    CompanionAnimationState.sleep: [
      'assets/animations/companion/sleep/frame_01.png',
      'assets/animations/companion/sleep/frame_02.png',
      'assets/animations/companion/sleep/frame_03.png',
      'assets/animations/companion/sleep/frame_04.png',
      'assets/animations/companion/sleep/frame_05.png',
    ],
  };

  late List<String> _sequence;
  int _sequenceIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _rebuildSequence();
    _startLoop();
  }

  @override
  void didUpdateWidget(covariant CompanionFigure oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.animationState != widget.animationState) {
      _rebuildSequence();
      _startLoop();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _rebuildSequence() {
    final baseFrames =
        _animationFrames[widget.animationState] ??
        _animationFrames[CompanionAnimationState.idle]!;
    _sequence = _buildPingPong(baseFrames);
    _sequenceIndex = 0;
  }

  void _startLoop() {
    _timer?.cancel();
    if (_sequence.length <= 1) {
      return;
    }
    _timer = Timer.periodic(_frameStep, (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _sequenceIndex = (_sequenceIndex + 1) % _sequence.length;
      });
    });
  }

  List<String> _buildPingPong(List<String> frames) {
    if (frames.length <= 2) {
      return List<String>.from(frames);
    }
    return [
      ...frames,
      ...frames.reversed.skip(1).skip(1),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final currentAsset = _sequence[_sequenceIndex];

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
          currentAsset,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
          gaplessPlayback: true,
        ),
      ),
    );
  }
}
