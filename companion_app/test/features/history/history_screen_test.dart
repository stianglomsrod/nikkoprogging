import 'package:companion_app/core/feedback/feedback_item.dart';
import 'package:companion_app/core/feedback/feedback_repository.dart';
import 'package:companion_app/core/history/history_entry.dart';
import 'package:companion_app/core/history/in_memory_history_repository.dart';
import 'package:companion_app/core/models/sinnsstemning.dart';
import 'package:companion_app/features/history/history_screen.dart';
import 'package:companion_app/features/history/widgets/day_activity_bar.dart';
import 'package:companion_app/features/history/widgets/day_detail_view.dart';
import 'package:companion_app/features/history/widgets/history_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _InMemoryFeedbackRepository implements FeedbackRepository {
  @override
  Future<void> append(FeedbackItem item) async {}

  @override
  Future<List<FeedbackItem>> readAll() async => const <FeedbackItem>[];

  @override
  Future<FeedbackItem?> readById(String id) async => null;
}

void main() {
  testWidgets(
    'shows supportive empty state when there is no history activity',
    (WidgetTester tester) async {
      final repository = InMemoryHistoryRepository();
      final feedbackRepository = _InMemoryFeedbackRepository();

      await tester.pumpWidget(
        MaterialApp(
          home: HistoryScreen(
            historyRepository: repository,
            feedbackRepository: feedbackRepository,
            nowProvider: () => DateTime(2026, 6, 20, 12),
          ),
        ),
      );

      expect(find.byType(HistoryEmptyState), findsOneWidget);
      expect(find.text('Noen dager er roligere.'), findsOneWidget);
      expect(
        find.textContaining('Her er det stille foreløpig.'),
        findsOneWidget,
      );
      expect(find.byType(DayActivityBar), findsNothing);
    },
  );

  testWidgets('renders seven daily bars when activity exists', (
    WidgetTester tester,
  ) async {
    final repository = InMemoryHistoryRepository();
    final feedbackRepository = _InMemoryFeedbackRepository();
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
        taskTitleSnapshot: 'Rydd skrivebordet i to minutter',
      ),
    ]);

    await tester.pumpWidget(
      MaterialApp(
        home: HistoryScreen(
          historyRepository: repository,
          feedbackRepository: feedbackRepository,
          nowProvider: () => DateTime(2026, 6, 20, 12),
        ),
      ),
    );

    expect(find.byType(HistoryEmptyState), findsNothing);
    expect(find.byType(DayActivityBar), findsNWidgets(7));
    expect(find.text('Små spor gjennom uken'), findsOneWidget);

    final bars = tester.widgetList<DayActivityBar>(find.byType(DayActivityBar));
    expect(bars.any((bar) => bar.summary.completedTaskCount > 0), isTrue);
  });

  testWidgets('tapping a day bar opens day detail view', (
    WidgetTester tester,
  ) async {
    final repository = InMemoryHistoryRepository();
    final feedbackRepository = _InMemoryFeedbackRepository();
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
        taskTitleSnapshot: 'Rydd skrivebordet i to minutter',
      ),
      HistoryEventRecord(
        eventId: 'event_symbol',
        action: HistoryEventAction.saved,
        timestamp: DateTime(2026, 6, 18, 9, 8),
        label: 'Symbol valgt',
      ),
    ]);

    await tester.pumpWidget(
      MaterialApp(
        home: HistoryScreen(
          historyRepository: repository,
          feedbackRepository: feedbackRepository,
          nowProvider: () => DateTime(2026, 6, 18, 12),
        ),
      ),
    );

    await tester.tap(find.byKey(const ValueKey('history-day-bar-tap-6')));
    await tester.pumpAndSettle();

    expect(find.byType(DayDetailView), findsOneWidget);
    expect(find.textContaining('Detaljer for 18.06.2026'), findsOneWidget);
    expect(find.text('Fullførte oppgaver'), findsOneWidget);

    expect(
      find.textContaining('Rydd skrivebordet i to minutter'),
      findsOneWidget,
    );
  });
}
