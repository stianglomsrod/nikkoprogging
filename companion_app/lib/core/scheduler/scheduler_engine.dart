import 'dart:math';

import 'package:companion_app/core/models/focus_area.dart';
import 'package:companion_app/core/models/modus.dart';

class SchedulerEngine {
  SchedulerEngine({Random? random}) : _random = random ?? Random();

  final Random _random;

  FocusArea? selectEligibleFocusArea({
    required List<FocusArea> focusAreas,
    required Map<String, int> promptsUsed,
    required int currentHour,
  }) {
    final eligible = focusAreas.where((area) {
      if (!area.enabled) {
        return false;
      }
      if (!area.isActiveAtHour(currentHour)) {
        return false;
      }
      final used = promptsUsed[area.id] ?? 0;
      return used < area.modus.maxPrompts;
    }).toList();

    if (eligible.isEmpty) {
      return null;
    }
    return eligible[_random.nextInt(eligible.length)];
  }
}
