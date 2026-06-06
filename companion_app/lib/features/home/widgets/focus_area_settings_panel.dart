import 'package:companion_app/core/models/focus_area.dart';
import 'package:companion_app/core/models/modus.dart';
import 'package:companion_app/features/home/widgets/active_time_range_control.dart';
import 'package:companion_app/features/home/widgets/modus_selector.dart';
import 'package:flutter/material.dart';

class FocusAreaSettingsPanel extends StatelessWidget {
  const FocusAreaSettingsPanel({
    super.key,
    required this.area,
    required this.rangeLabel,
    required this.startHourLabel,
    required this.endHourLabel,
    required this.onEnabledChanged,
    required this.onModusChanged,
    required this.onRangeChanged,
  });

  final FocusArea area;
  final String rangeLabel;
  final String startHourLabel;
  final String endHourLabel;
  final ValueChanged<bool> onEnabledChanged;
  final ValueChanged<Modus> onModusChanged;
  final ValueChanged<RangeValues> onRangeChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(area.name, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: const Text('Aktivert'),
              value: area.enabled,
              onChanged: onEnabledChanged,
            ),
            const SizedBox(height: 8),
            const Text('Modus'),
            const SizedBox(height: 8),
            ModusSelector(
              selectedModus: area.modus,
              onSelected: onModusChanged,
            ),
            const SizedBox(height: 20),
            ActiveTimeRangeControl(
              startHour: area.startHour,
              endHour: area.endHour,
              rangeLabel: rangeLabel,
              startHourLabel: startHourLabel,
              endHourLabel: endHourLabel,
              onChanged: onRangeChanged,
            ),
          ],
        ),
      ),
    );
  }
}
