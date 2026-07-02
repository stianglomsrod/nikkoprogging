import 'package:companion_app/core/events/companion_identity.dart';
import 'package:flutter/material.dart';

class SleepSoundFeatureSheet extends StatefulWidget {
  const SleepSoundFeatureSheet({
    super.key,
    required this.initialSound,
    required this.initialDurationMinutes,
    required this.onPreview,
    required this.onStopPreview,
    required this.onSave,
  });

  final CompanionSleepSoundOption initialSound;
  final int initialDurationMinutes;
  final ValueChanged<CompanionSleepSoundOption> onPreview;
  final VoidCallback onStopPreview;
  final void Function(CompanionSleepSoundOption sound, int durationMinutes)
  onSave;

  @override
  State<SleepSoundFeatureSheet> createState() => _SleepSoundFeatureSheetState();
}

class _SleepSoundFeatureSheetState extends State<SleepSoundFeatureSheet> {
  static const List<int> _durationOptions = <int>[5, 10, 15, 20];

  late CompanionSleepSoundOption _selectedSound;
  late int _selectedDurationMinutes;
  bool _isPreviewPlaying = false;

  @override
  void initState() {
    super.initState();
    _selectedSound = widget.initialSound;
    _selectedDurationMinutes =
        _durationOptions.contains(widget.initialDurationMinutes)
        ? widget.initialDurationMinutes
        : 15;
  }

  @override
  void dispose() {
    if (_isPreviewPlaying) {
      widget.onStopPreview();
    }
    super.dispose();
  }

  void _togglePreview() {
    if (_selectedSound == CompanionSleepSoundOption.none) {
      return;
    }

    if (_isPreviewPlaying) {
      widget.onStopPreview();
      setState(() {
        _isPreviewPlaying = false;
      });
      return;
    }

    widget.onPreview(_selectedSound);
    setState(() {
      _isPreviewPlaying = true;
    });
  }

  void _onSelectedSound(CompanionSleepSoundOption option) {
    if (_isPreviewPlaying) {
      widget.onStopPreview();
      _isPreviewPlaying = false;
    }

    setState(() {
      _selectedSound = option;
    });
  }

  void _saveAndClose() {
    if (_isPreviewPlaying) {
      widget.onStopPreview();
      _isPreviewPlaying = false;
    }
    widget.onSave(_selectedSound, _selectedDurationMinutes);
    Navigator.of(context).pop();
  }

  void _close() {
    if (_isPreviewPlaying) {
      widget.onStopPreview();
      _isPreviewPlaying = false;
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
        child: SingleChildScrollView(
          child: Column(
            key: const ValueKey('sleep-feature-sheet'),
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Søvnlyd',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 6),
              const Text('Velg varighet, lyd og forhåndslytt ved behov.'),
              const SizedBox(height: 14),
              const Text(
                'Varighet',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final minutes in _durationOptions)
                    ChoiceChip(
                      key: ValueKey('sleep-duration-option-$minutes'),
                      label: Text('$minutes min'),
                      selected: _selectedDurationMinutes == minutes,
                      onSelected: (_) {
                        setState(() {
                          _selectedDurationMinutes = minutes;
                        });
                      },
                    ),
                ],
              ),
              const SizedBox(height: 14),
              const Text(
                'Lyd',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final option in CompanionSleepSoundOption.values)
                    ChoiceChip(
                      key: ValueKey('sleep-sound-option-${option.name}'),
                      label: Text(option.label),
                      selected: _selectedSound == option,
                      onSelected: (_) => _onSelectedSound(option),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                key: const ValueKey('sleep-sound-preview-button'),
                onPressed: _selectedSound == CompanionSleepSoundOption.none
                    ? null
                    : _togglePreview,
                child: Text(_isPreviewPlaying ? 'Stopp lyd' : 'Spill av lyd'),
              ),
              const SizedBox(height: 12),
              FilledButton(
                key: const ValueKey('sleep-feature-save-button'),
                onPressed: _saveAndClose,
                child: const Text('Lagre og start'),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                key: const ValueKey('sleep-feature-close-button'),
                onPressed: _close,
                child: const Text('Lukk'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
