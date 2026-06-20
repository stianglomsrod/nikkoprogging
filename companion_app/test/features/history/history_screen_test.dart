import 'package:companion_app/core/history/history_entry.dart';
import 'package:companion_app/core/history/in_memory_history_repository.dart';
import 'package:companion_app/core/models/sinnsstemning.dart';
import 'package:companion_app/features/history/history_screen.dart';
import 'package:companion_app/features/history/widgets/day_activity_bar.dart';
import 'package:companion_app/features/history/widgets/history_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'shows supportive empty state when there is no history activity',
    (WidgetTester tester) async {
      final repository = InMemoryHistoryRepository();

      await tester.pumpWidget(
        MaterialApp(
          home: HistoryScreen(
            historyRepository: repository,
            nowProvider: () => DateTime(2026, 6, 20, 12),
          ),
        ),
      );

      expect(find.byType(HistoryEmptyState), findsOneWidget);
      expect(find.text('Noen dager er roligere.'), findsOneWidget);
      expect(find.byType(DayActivityBar), findsNothing);
    },
  );

  testWidgets('renders seven daily bars when activity exists', (
    WidgetTester tester,
  ) async {
    final repository = InMemoryHistoryRepository();
    repository.appendEntries([
      HistoryMoodRecord(
        mood: Sinnsstemning.ok,
        timestamp: DateTime(2026, 6, 18, 9, 0),
      ),
      HistoryAttemptRecord(
        taskId: 'task-1',
        focusAreaId: 'study',
        outcome: HistoryAttemptOutcome.completed,
        mood: Sinnsstemning.ok,
        timestamp: DateTime(2026, 6, 18, 9, 5),
      ),
    ]);

    await tester.pumpWidget(
      MaterialApp(
        home: HistoryScreen(
          historyRepository: repository,
          nowProvider: () => DateTime(2026, 6, 20, 12),
        ),
      ),
    );

    expect(find.byType(HistoryEmptyState), findsNothing);
    expect(find.byType(DayActivityBar), findsNWidgets(7));

    final bars = tester.widgetList<DayActivityBar>(find.byType(DayActivityBar));
    expect(bars.any((bar) => bar.summary.completedTaskCount > 0), isTrue);
  });
}
