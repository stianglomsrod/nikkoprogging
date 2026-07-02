import 'package:companion_app/core/models/focus_area.dart';
import 'package:companion_app/core/models/modus.dart';
import 'package:companion_app/features/home/widgets/active_time_range_control.dart';
import 'package:companion_app/features/home/widgets/modus_selector.dart';
import 'package:flutter/material.dart';

class FocusAreaSettingsPanel extends StatelessWidget {
  const FocusAreaSettingsPanel({
    super.key,
    required this.area,
    required this.onEnabledChanged,
    required this.onModusChanged,
    required this.onWindowCountChanged,
    required this.onRangeChanged,
  });

  final FocusArea area;
  final ValueChanged<bool> onEnabledChanged;
  final ValueChanged<Modus> onModusChanged;
  final ValueChanged<int> onWindowCountChanged;
  final void Function(int index, RangeValues values) onRangeChanged;

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
            Row(
              children: [
                const Text('Aktive tidsrom'),
                const Spacer(),
                SegmentedButton<int>(
                  segments: const [
                    ButtonSegment<int>(value: 1, label: Text('1')),
                    ButtonSegment<int>(value: 2, label: Text('2')),
                  ],
                  selected: <int>{area.activeWindows.length.clamp(1, 2)},
                  onSelectionChanged: (selection) {
                    if (selection.isEmpty) {
                      return;
                    }
                    onWindowCountChanged(selection.first);
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            for (int index = 0; index < area.activeWindows.length; index++) ...[
              if (index > 0) const SizedBox(height: 14),
              ActiveTimeRangeControl(
                title: area.activeWindows.length == 1
                    ? 'Aktivt tidsrom'
                    : 'Aktivt tidsrom ${index + 1}',
                startHour: area.activeWindows[index].startHour,
                endHour: area.activeWindows[index].endHour,
                rangeLabel: _rangeLabel(
                  area.activeWindows[index].startHour,
                  area.activeWindows[index].endHour,
                ),
                startHourLabel: _hourLabel(area.activeWindows[index].startHour),
                endHourLabel: _hourLabel(area.activeWindows[index].endHour),
                onChanged: (values) => onRangeChanged(index, values),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _hourLabel(int hour) => '${hour.toString().padLeft(2, '0')}:00';

  String _rangeLabel(int start, int end) {
    return '${_hourLabel(start)} - ${_hourLabel(end)}';
  }
}
