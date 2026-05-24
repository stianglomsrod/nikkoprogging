import 'dart:math';

import 'package:companion_app/core/models/attempt_entry.dart';
import 'package:companion_app/core/models/sinnsstemning.dart';
import 'package:companion_app/core/models/task_item.dart';

class TaskSelector {
  TaskSelector({Random? random}) : _random = random ?? Random();

  final Random _random;

  TaskItem? selectTask({
    required String focusAreaId,
    required Sinnsstemning mood,
    required List<TaskItem> allTasks,
    required List<AttemptEntry> history,
    required List<String> recentFailedTaskIds,
  }) {
    final byArea = allTasks
        .where((task) => task.focusAreaId == focusAreaId)
        .toList();
    if (byArea.isEmpty) {
      return null;
    }

    final filtered = byArea
        .where((task) => !recentFailedTaskIds.contains(task.id))
        .toList(growable: false);

    final candidates = filtered.isNotEmpty ? filtered : byArea;
    final targetDifficulty = _targetDifficulty(mood, history);

    candidates.sort((a, b) {
      final ad = (a.difficulty - targetDifficulty).abs();
      final bd = (b.difficulty - targetDifficulty).abs();
      return ad.compareTo(bd);
    });

    final bestDistance = (candidates.first.difficulty - targetDifficulty).abs();
    final near = candidates
        .where(
          (task) => (task.difficulty - targetDifficulty).abs() == bestDistance,
        )
        .toList();
    return near[_random.nextInt(near.length)];
  }

  int _targetDifficulty(Sinnsstemning mood, List<AttemptEntry> history) {
    int target;
    switch (mood) {
      case Sinnsstemning.negativ:
        target = 1;
      case Sinnsstemning.ok:
        target = 2;
      case Sinnsstemning.energisk:
        target = 3;
    }

    if (history.isEmpty) {
      return target;
    }

    final doneCount = history.where((entry) => entry.done).length;
    final successRate = doneCount / history.length;

    if (successRate > 0.75) {
      target += 1;
    } else if (successRate < 0.40) {
      target -= 1;
    }

    if (target < 1) {
      return 1;
    }
    if (target > 3) {
      return 3;
    }
    return target;
  }
}
