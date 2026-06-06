import 'package:companion_app/core/models/focus_area.dart';
import 'package:companion_app/features/home/widgets/focus_area_circle_selector.dart';
import 'package:companion_app/features/home/widgets/focus_area_settings_panel.dart';
import 'package:companion_app/features/home/widgets/prototype_time_panel.dart';
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
          FocusAreaCircleSelector(
            focusAreas: _localFocusAreas,
            selectedAreaId: _selectedAreaId,
            onSelectArea: (areaId) {
              setState(() {
                _selectedAreaId = areaId;
              });
            },
          ),
          const SizedBox(height: 24),
          FocusAreaSettingsPanel(
            area: area,
            rangeLabel: _rangeLabel(area.startHour, area.endHour),
            startHourLabel: _hourLabel(area.startHour),
            endHourLabel: _hourLabel(area.endHour),
            onEnabledChanged: (value) {
              _updateArea(
                area.id,
                (current) => current.copyWith(enabled: value),
              );
            },
            onModusChanged: (mode) {
              _updateArea(area.id, (current) => current.copyWith(modus: mode));
            },
            onRangeChanged: (values) {
              final start = values.start.round().clamp(0, 23);
              final rawEnd = values.end.round().clamp(1, 24);
              final end = rawEnd <= start ? start + 1 : rawEnd;
              _updateArea(
                area.id,
                (current) => current.copyWith(startHour: start, endHour: end),
              );
            },
          ),
          const SizedBox(height: 20),
          PrototypeTimePanel(
            hourLabel: _hourLabel(_localHour),
            value: _localHour,
            onChanged: (value) {
              setState(() {
                _localHour = value;
              });
            },
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
