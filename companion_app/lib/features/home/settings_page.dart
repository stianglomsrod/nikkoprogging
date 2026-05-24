import 'package:companion_app/core/models/focus_area.dart';
import 'package:companion_app/core/models/modus.dart';
import 'package:flutter/material.dart';

class SettingsResult {
  const SettingsResult({required this.focusAreas, required this.simulatedHour});

  final List<FocusArea> focusAreas;
  final int simulatedHour;
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
    required this.focusAreas,
    required this.simulatedHour,
  });

  final List<FocusArea> focusAreas;
  final int simulatedHour;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late List<FocusArea> _localFocusAreas;
  late int _localHour;
  late String _selectedAreaId;

  @override
  void initState() {
    super.initState();
    _localFocusAreas = widget.focusAreas
        .map(
          (area) => area.copyWith(
            enabled: area.enabled,
            startHour: area.startHour,
            endHour: area.endHour,
            modus: area.modus,
          ),
        )
        .toList(growable: true);
    _localHour = widget.simulatedHour;
    _selectedAreaId = _localFocusAreas.first.id;
  }

  FocusArea get _selectedArea =>
      _localFocusAreas.firstWhere((area) => area.id == _selectedAreaId);

  void _saveAndClose() {
    Navigator.of(context).pop(
      SettingsResult(focusAreas: _localFocusAreas, simulatedHour: _localHour),
    );
  }

  void _updateArea(String areaId, FocusArea Function(FocusArea area) updater) {
    setState(() {
      _localFocusAreas = _localFocusAreas
          .map((area) => area.id == areaId ? updater(area) : area)
          .toList(growable: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final area = _selectedArea;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Innstillinger'),
        actions: [
          TextButton(onPressed: _saveAndClose, child: const Text('Lagre')),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Velg et Fokusomrade',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            runSpacing: 16,
            children: [
              for (final focusArea in _localFocusAreas)
                _FocusAreaCircle(
                  area: focusArea,
                  selected: focusArea.id == _selectedAreaId,
                  onTap: () {
                    setState(() {
                      _selectedAreaId = focusArea.id;
                    });
                  },
                ),
            ],
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    area.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Aktivert'),
                    value: area.enabled,
                    onChanged: (value) {
                      _updateArea(area.id, (current) => current.copyWith(enabled: value));
                    },
                  ),
                  const SizedBox(height: 8),
                  const Text('Modus'),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      for (final mode in Modus.values)
                        ChoiceChip(
                          label: Text(mode.label),
                          selected: area.modus == mode,
                          onSelected: (_) {
                            _updateArea(area.id, (current) => current.copyWith(modus: mode));
                          },
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text('Aktivt tidsrom'),
                  const SizedBox(height: 6),
                  Text(_rangeLabel(area.startHour, area.endHour)),
                  RangeSlider(
                    values: RangeValues(
                      area.startHour.toDouble(),
                      area.endHour.toDouble(),
                    ),
                    min: 0,
                    max: 24,
                    divisions: 24,
                    labels: RangeLabels(
                      _hourLabel(area.startHour),
                      _hourLabel(area.endHour),
                    ),
                    onChanged: (values) {
                      final start = values.start.round().clamp(0, 23);
                      final rawEnd = values.end.round().clamp(1, 24);
                      final end = rawEnd <= start ? start + 1 : rawEnd;
                      _updateArea(
                        area.id,
                        (current) => current.copyWith(startHour: start, endHour: end),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Prototype-tid'),
                  const SizedBox(height: 6),
                  Text(_hourLabel(_localHour)),
                  Slider(
                    value: _localHour.toDouble(),
                    min: 0,
                    max: 23,
                    divisions: 23,
                    label: _hourLabel(_localHour),
                    onChanged: (value) {
                      setState(() {
                        _localHour = value.round();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _hourLabel(int hour) => '${hour.toString().padLeft(2, '0')}:00';

  String _rangeLabel(int start, int end) {
    return '${_hourLabel(start)} - ${_hourLabel(end)}';
  }
}

class _FocusAreaCircle extends StatelessWidget {
  const _FocusAreaCircle({
    required this.area,
    required this.selected,
    required this.onTap,
  });

  final FocusArea area;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final fillColor = area.enabled ? colors.secondaryContainer : colors.surfaceContainerHighest;
    final borderColor = selected ? colors.primary : colors.outlineVariant;
    final textColor = area.enabled ? colors.onSecondaryContainer : colors.onSurfaceVariant;

    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: fillColor,
              border: Border.all(color: borderColor, width: selected ? 2 : 1),
            ),
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              area.name,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: textColor),
            ),
          ),
        ],
      ),
    );
  }
}