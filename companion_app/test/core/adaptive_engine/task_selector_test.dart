import 'dart:math';

import 'package:companion_app/core/adaptive_engine/task_selector.dart';
import 'package:companion_app/core/models/attempt_entry.dart';
import 'package:companion_app/core/models/sinnsstemning.dart';
import 'package:companion_app/core/models/task_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TaskSelector', () {
    const focusAreaId = 'household';

    final tasks = [
      const TaskItem(
        id: 'easy',
        focusAreaId: focusAreaId,
        title: 'Easy',
        difficulty: 1,
      ),
      const TaskItem(
        id: 'medium',
        focusAreaId: focusAreaId,
        title: 'Medium',
        difficulty: 2,
      ),
      const TaskItem(
        id: 'hard',
        focusAreaId: focusAreaId,
        title: 'Hard',
        difficulty: 3,
      ),
    ];

    test('negativ mood prefers easier tasks', () {
      final selector = TaskSelector(random: _FixedRandom(0));

      final selected = selector.selectTask(
        focusAreaId: focusAreaId,
        mood: Sinnsstemning.negativ,
        allTasks: tasks,
        history: const [],
        recentFailedTaskIds: const [],
      );

      expect(selected?.id, 'easy');
    });

    test('energisk mood may select harder tasks', () {
      final selector = TaskSelector(random: _FixedRandom(0));

      final selected = selector.selectTask(
        focusAreaId: focusAreaId,
        mood: Sinnsstemning.energisk,
        allTasks: tasks,
        history: const [],
        recentFailedTaskIds: const [],
      );

      expect(selected?.id, 'hard');
    });

    test('low success rate does not push difficulty upward', () {
      final selector = TaskSelector(random: _FixedRandom(0));
      final lowSuccessHistory = [
        _attempt(done: false),
        _attempt(done: false),
        _attempt(done: true),
        _attempt(done: false),
        _attempt(done: false),
      ];

      final selected = selector.selectTask(
        focusAreaId: focusAreaId,
        mood: Sinnsstemning.energisk,
        allTasks: tasks,
        history: lowSuccessHistory,
        recentFailedTaskIds: const [],
      );

      expect(selected?.id, 'medium');
      expect(selected?.difficulty, lessThanOrEqualTo(2));
    });

    test('high success rate may allow slightly harder tasks', () {
      final selector = TaskSelector(random: _FixedRandom(0));
      final highSuccessHistory = [
        _attempt(done: true),
        _attempt(done: true),
        _attempt(done: true),
        _attempt(done: true),
      ];

      final selected = selector.selectTask(
        focusAreaId: focusAreaId,
        mood: Sinnsstemning.ok,
        allTasks: tasks,
        history: highSuccessHistory,
        recentFailedTaskIds: const [],
      );

      expect(selected?.id, 'hard');
    });

    test('recently failed task is avoided when alternatives exist', () {
      final selector = TaskSelector(random: _FixedRandom(0));
      final tasksWithAlternative = [
        const TaskItem(
          id: 'easyA',
          focusAreaId: focusAreaId,
          title: 'Easy A',
          difficulty: 1,
        ),
        const TaskItem(
          id: 'easyB',
          focusAreaId: focusAreaId,
          title: 'Easy B',
          difficulty: 1,
        ),
      ];

      final selected = selector.selectTask(
        focusAreaId: focusAreaId,
        mood: Sinnsstemning.negativ,
        allTasks: tasksWithAlternative,
        history: const [],
        recentFailedTaskIds: const ['easyA'],
      );

      expect(selected?.id, 'easyB');
    });

    test('safe fallback when all tasks are marked recently failed', () {
      final selector = TaskSelector(random: _FixedRandom(0));

      final selected = selector.selectTask(
        focusAreaId: focusAreaId,
        mood: Sinnsstemning.negativ,
        allTasks: tasks,
        history: const [],
        recentFailedTaskIds: const ['easy', 'medium', 'hard'],
      );

      expect(selected, isNotNull);
      expect(['easy', 'medium', 'hard'], contains(selected!.id));
    });
  });
}

AttemptEntry _attempt({required bool done}) {
  return AttemptEntry(
    taskId: 't',
    focusAreaId: 'household',
    done: done,
    mood: Sinnsstemning.ok,
    timestamp: DateTime(2026, 1, 1),
  );
}

class _FixedRandom implements Random {
  _FixedRandom(this._value);

  final int _value;

  @override
  bool nextBool() => _value.isEven;

  @override
  double nextDouble() => 0.0;

  @override
  int nextInt(int max) => _value % max;
}
