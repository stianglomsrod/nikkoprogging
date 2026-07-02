import 'package:companion_app/core/events/companion_identity.dart';
import 'package:flutter/material.dart';

class BackgroundMusicSettingsPanel extends StatefulWidget {
  const BackgroundMusicSettingsPanel({
    super.key,
    required this.selected,
    required this.onChanged,
    required this.onPreview,
    required this.onStopPreview,
  });

  final CompanionBackgroundMusicOption selected;
  final ValueChanged<CompanionBackgroundMusicOption> onChanged;
  final ValueChanged<CompanionBackgroundMusicOption> onPreview;
  final VoidCallback onStopPreview;

  @override
  State<BackgroundMusicSettingsPanel> createState() =>
      _BackgroundMusicSettingsPanelState();
}

class _BackgroundMusicSettingsPanelState extends State<BackgroundMusicSettingsPanel> {
  bool _isPreviewPlaying = false;

  @override
  void dispose() {
    if (_isPreviewPlaying) {
      widget.onStopPreview();
    }
    super.dispose();
  }

  void _togglePreview() {
    if (widget.selected == CompanionBackgroundMusicOption.none) {
      return;
    }

    if (_isPreviewPlaying) {
      widget.onStopPreview();
      setState(() {
        _isPreviewPlaying = false;
      });
      return;
    }

    widget.onPreview(widget.selected);
    setState(() {
      _isPreviewPlaying = true;
    });
  }

  void _onSelected(CompanionBackgroundMusicOption option) {
    if (_isPreviewPlaying) {
      widget.onStopPreview();
      _isPreviewPlaying = false;
    }
    widget.onChanged(option);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bakgrunnsmusikk',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            const Text('Velg en rolig idle-lyd som kan gå i bakgrunnen.'),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final option in CompanionBackgroundMusicOption.values)
                  ChoiceChip(
                    key: ValueKey('settings-background-music-option-${option.name}'),
                    label: Text(option.label),
                    selected: widget.selected == option,
                    onSelected: (_) => _onSelected(option),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              key: const ValueKey('settings-background-music-preview-button'),
              onPressed: widget.selected == CompanionBackgroundMusicOption.none
                  ? null
                  : _togglePreview,
              child: Text(_isPreviewPlaying ? 'Stopp lyd' : 'Spill av lyd'),
            ),
            if (_isPreviewPlaying) ...[
              const SizedBox(height: 8),
              Text('Forhåndslytter: ${widget.selected.label}'),
            ],
          ],
        ),
      ),
    );
  }
}
