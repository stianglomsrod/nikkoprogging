import 'package:companion_app/core/models/focus_area.dart';
import 'package:flutter/material.dart';

class FocusAreaCircleButton extends StatelessWidget {
  const FocusAreaCircleButton({
    super.key,
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
    final fillColor = area.enabled
        ? colors.secondaryContainer
        : colors.surfaceContainerHighest;
    final borderColor = selected ? colors.primary : colors.outlineVariant;
    final textColor = area.enabled
        ? colors.onSecondaryContainer
        : colors.onSurfaceVariant;

    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
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
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: textColor),
        ),
      ),
    );
  }
}
