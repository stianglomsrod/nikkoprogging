import 'package:companion_app/core/models/focus_area.dart';
import 'package:companion_app/features/home/widgets/focus_area_circle_button.dart';
import 'package:flutter/material.dart';

class FocusAreaCircleSelector extends StatelessWidget {
  const FocusAreaCircleSelector({
    super.key,
    required this.focusAreas,
    required this.selectedAreaId,
    required this.onSelectArea,
  });

  final List<FocusArea> focusAreas;
  final String selectedAreaId;
  final ValueChanged<String> onSelectArea;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Velg et Fokusområde',
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 16,
          runSpacing: 16,
          children: [
            for (final focusArea in focusAreas)
              FocusAreaCircleButton(
                key: ValueKey('focus-area-circle-${focusArea.id}'),
                area: focusArea,
                selected: focusArea.id == selectedAreaId,
                onTap: () => onSelectArea(focusArea.id),
              ),
          ],
        ),
      ],
    );
  }
}
