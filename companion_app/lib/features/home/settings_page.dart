import 'package:companion_app/core/events/companion_identity.dart';
import 'package:companion_app/core/models/focus_area.dart';
import 'package:companion_app/features/home/widgets/background_tone_settings_panel.dart';
import 'package:companion_app/features/home/widgets/companion_name_settings_panel.dart';
import 'package:companion_app/features/home/widgets/focus_area_circle_selector.dart';
import 'package:companion_app/features/home/widgets/focus_area_settings_panel.dart';
import 'package:companion_app/features/home/widgets/prototype_time_panel.dart';
import 'package:companion_app/features/home/widgets/symbol_settings_panel.dart';
import 'package:companion_app/features/home/widgets/user_name_settings_panel.dart';
import 'package:flutter/material.dart';

class SettingsResult {
  const SettingsResult({
    required this.focusAreas,
    required this.selectedAreaId,
    required this.simulatedHour,
    required this.companionName,
    required this.userName,
    required this.symbol,
    required this.backgroundTone,
  });

  final List<FocusArea> focusAreas;
  final String selectedAreaId;
  final int simulatedHour;
  final String? companionName;
  final String? userName;
  final CompanionSymbolOption symbol;
  final CompanionBackgroundTone backgroundTone;
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
    required this.focusAreas,
    required this.initialSelectedAreaId,
    required this.simulatedHour,
    required this.allowCompanionNameEditing,
    required this.allowUserNameEditing,
    required this.allowSymbolEditing,
    required this.allowBackgroundToneEditing,
    required this.initialSymbol,
    required this.initialBackgroundTone,
    this.initialCompanionName,
    this.initialUserName,
  });

  final List<FocusArea> focusAreas;
  final String initialSelectedAreaId;
  final int simulatedHour;
  final bool allowCompanionNameEditing;
  final bool allowUserNameEditing;
  final bool allowSymbolEditing;
  final bool allowBackgroundToneEditing;
  final String? initialCompanionName;
  final String? initialUserName;
  final CompanionSymbolOption initialSymbol;
  final CompanionBackgroundTone initialBackgroundTone;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late List<FocusArea> _localFocusAreas;
  late int _localHour;
  late String _selectedAreaId;
  late String _localCompanionName;
  late String _localUserName;
  late CompanionSymbolOption _localSymbol;
  late CompanionBackgroundTone _localBackgroundTone;

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
    final hasInitialSelected = _localFocusAreas.any(
      (area) => area.id == widget.initialSelectedAreaId,
    );
    _selectedAreaId = hasInitialSelected
        ? widget.initialSelectedAreaId
        : _localFocusAreas.first.id;
    _localCompanionName = widget.initialCompanionName ?? '';
    _localUserName = widget.initialUserName ?? '';
    _localSymbol = widget.initialSymbol;
    _localBackgroundTone = widget.initialBackgroundTone;
  }

  FocusArea get _selectedArea =>
      _localFocusAreas.firstWhere((area) => area.id == _selectedAreaId);

  void _saveAndClose() {
    final normalizedCompanionName = _localCompanionName.trim();
    final normalizedUserName = _localUserName.trim();
    Navigator.of(context).pop(
      SettingsResult(
        focusAreas: _localFocusAreas,
        selectedAreaId: _selectedAreaId,
        simulatedHour: _localHour,
        companionName: normalizedCompanionName.isEmpty
            ? null
            : normalizedCompanionName,
        userName: normalizedUserName.isEmpty ? null : normalizedUserName,
        symbol: _localSymbol,
        backgroundTone: _localBackgroundTone,
      ),
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
          if (widget.allowCompanionNameEditing) ...[
            const SizedBox(height: 20),
            CompanionNameSettingsPanel(
              initialName: _localCompanionName,
              onChanged: (value) {
                _localCompanionName = value;
              },
            ),
          ],
          if (widget.allowUserNameEditing) ...[
            const SizedBox(height: 20),
            UserNameSettingsPanel(
              initialName: _localUserName,
              onChanged: (value) {
                _localUserName = value;
              },
            ),
          ],
          if (widget.allowSymbolEditing) ...[
            const SizedBox(height: 20),
            SymbolSettingsPanel(
              selected: _localSymbol,
              onChanged: (value) {
                setState(() {
                  _localSymbol = value;
                });
              },
            ),
          ],
          if (widget.allowBackgroundToneEditing) ...[
            const SizedBox(height: 20),
            BackgroundToneSettingsPanel(
              selected: _localBackgroundTone,
              onChanged: (value) {
                setState(() {
                  _localBackgroundTone = value;
                });
              },
            ),
          ],
        ],
      ),
    );
  }

  String _hourLabel(int hour) => '${hour.toString().padLeft(2, '0')}:00';

  String _rangeLabel(int start, int end) {
    return '${_hourLabel(start)} - ${_hourLabel(end)}';
  }
}
