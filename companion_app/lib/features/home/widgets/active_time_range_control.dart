import 'package:flutter/material.dart';

class ActiveTimeRangeControl extends StatelessWidget {
  const ActiveTimeRangeControl({
    super.key,
    required this.startHour,
    required this.endHour,
    required this.rangeLabel,
    required this.startHourLabel,
    required this.endHourLabel,
    required this.onChanged,
  });

  final int startHour;
  final int endHour;
  final String rangeLabel;
  final String startHourLabel;
  final String endHourLabel;
  final ValueChanged<RangeValues> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Aktivt tidsrom'),
        const SizedBox(height: 6),
        Text(rangeLabel),
        RangeSlider(
          values: RangeValues(startHour.toDouble(), endHour.toDouble()),
          min: 0,
          max: 24,
          divisions: 24,
          labels: RangeLabels(startHourLabel, endHourLabel),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
