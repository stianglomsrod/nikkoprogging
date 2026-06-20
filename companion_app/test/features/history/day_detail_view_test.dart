import 'package:companion_app/core/history/day_history_summary.dart';
import 'package:companion_app/core/history/history_entry.dart';
import 'package:companion_app/core/models/sinnsstemning.dart';
import 'package:companion_app/features/history/widgets/day_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows supportive quiet-day copy when no activity exists', (
    WidgetTester tester,
  ) async {
    final day = DateTime(2026, 6, 20);

    await tester.pumpWidget(
      MaterialApp(
        home: DayDetailView(
          day: day,
          summary: DayHistorySummary.empty(day),
          entries: const <HistoryEntry>[],
        ),
      ),
    );

    expect(find.textContaining('Noen dager er roligere.'), findsOneWidget);
    expect(find.text('Rolig dag'), findsOneWidget);
    expect(find.text('Fullførte oppgaver'), findsNothing);
    expect(find.text('Hendelser'), findsNothing);
    expect(find.text('Tidspunkter med aktivitet'), findsNothing);
  });

  testWidgets('renders day detail sections with activity values', (
    WidgetTester tester,
  ) async {
    final day = DateTime(2026, 6, 21);

    final entries = <HistoryEntry>[
      HistoryMoodRecord(
        mood: Sinnsstemning.ok,
        timestamp: DateTime(2026, 6, 21, 9, 0),
      ),
      HistoryAttemptRecord(
        taskId: 'task-1',
        focusAreaId: 'study',
        outcome: HistoryAttemptOutcome.completed,
        mood: Sinnsstemning.ok,
        timestamp: DateTime(2026, 6, 21, 9, 5),
        taskTitleSnapshot: 'Ta fem minutter med matte',
      ),
      HistoryEventRecord(
        eventId: 'event_symbol',
        action: HistoryEventAction.saved,
        timestamp: DateTime(2026, 6, 21, 9, 15),
        label: 'Symbol valgt',
      ),
    ];

    final summary = DayHistorySummary(
      dayStart: DateTime(2026, 6, 21),
      completedTaskCount: 1,
      attemptCount: 1,
      notCompletedAttemptCount: 0,
      interruptedAttemptCount: 0,
      moodEntryCount: 1,
      moodCounts: const {Sinnsstemning.ok: 1},
      eventMarkers: [
        HistoryEventMarker(
          eventId: 'event_symbol',
          timestamp: DateTime(2026, 6, 21, 9, 15),
          label: 'Symbol valgt',
        ),
      ],
      activityMoments: [
        DateTime(2026, 6, 21, 9, 0),
        DateTime(2026, 6, 21, 9, 5),
        DateTime(2026, 6, 21, 9, 15),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: DayDetailView(day: day, summary: summary, entries: entries),
      ),
    );

    expect(find.text('Fullførte oppgaver'), findsOneWidget);
    expect(find.textContaining('Ta fem minutter med matte'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Hendelser'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();

    expect(find.text('Hendelser'), findsOneWidget);
    expect(find.textContaining('Symbol ble valgt - lagret'), findsOneWidget);
    expect(find.text('Tidspunkter med aktivitet'), findsOneWidget);
  });

  testWidgets('compacts repeated activity times for calm mobile readability', (
    WidgetTester tester,
  ) async {
    final day = DateTime(2026, 6, 22);

    final entries = <HistoryEntry>[
      HistoryEventRecord(
        eventId: 'event_user_name',
        action: HistoryEventAction.saved,
        timestamp: DateTime(2026, 6, 22, 13, 24),
        label: 'event_user_name',
      ),
    ];

    final summary = DayHistorySummary(
      dayStart: DateTime(2026, 6, 22),
      completedTaskCount: 0,
      attemptCount: 0,
      notCompletedAttemptCount: 0,
      interruptedAttemptCount: 0,
      moodEntryCount: 0,
      moodCounts: const {},
      eventMarkers: [
        HistoryEventMarker(
          eventId: 'event_user_name',
          timestamp: DateTime(2026, 6, 22, 13, 24),
        ),
      ],
      activityMoments: [
        DateTime(2026, 6, 22, 13, 24),
        DateTime(2026, 6, 22, 13, 24),
        DateTime(2026, 6, 22, 13, 24),
        DateTime(2026, 6, 22, 13, 38),
        DateTime(2026, 6, 22, 13, 38),
        DateTime(2026, 6, 22, 13, 49),
        DateTime(2026, 6, 22, 13, 50),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: DayDetailView(day: day, summary: summary, entries: entries),
      ),
    );

    expect(find.text('Tidspunkter med aktivitet'), findsOneWidget);
    expect(find.textContaining('13:24 (×3)'), findsOneWidget);
    expect(find.textContaining('13:38 (×2)'), findsOneWidget);
    expect(find.textContaining('13:49'), findsOneWidget);
    expect(find.textContaining('13:50'), findsOneWidget);
  });

  testWidgets(
    'groups repeated tasks and moods for calmer day-detail display',
    (WidgetTester tester) async {
      final day = DateTime(2026, 6, 23);

      final entries = <HistoryEntry>[
        HistoryAttemptRecord(
          taskId: 'task-1',
          focusAreaId: 'exercise',
          outcome: HistoryAttemptOutcome.completed,
          mood: Sinnsstemning.energisk,
          timestamp: DateTime(2026, 6, 23, 13, 24),
          taskTitleSnapshot: 'Kjør en sporty økt med intervaller.',
        ),
        HistoryAttemptRecord(
          taskId: 'task-2',
          focusAreaId: 'exercise',
          outcome: HistoryAttemptOutcome.completed,
          mood: Sinnsstemning.energisk,
          timestamp: DateTime(2026, 6, 23, 13, 30),
          taskTitleSnapshot: 'Kjør en sporty økt med intervaller.',
        ),
        HistoryAttemptRecord(
          taskId: 'task-3',
          focusAreaId: 'exercise',
          outcome: HistoryAttemptOutcome.completed,
          mood: Sinnsstemning.energisk,
          timestamp: DateTime(2026, 6, 23, 13, 35),
          taskTitleSnapshot: 'Kjør en sporty økt med intervaller.',
        ),
        HistoryMoodRecord(
          mood: Sinnsstemning.energisk,
          timestamp: DateTime(2026, 6, 23, 13, 24),
        ),
        HistoryMoodRecord(
          mood: Sinnsstemning.energisk,
          timestamp: DateTime(2026, 6, 23, 13, 38),
        ),
        HistoryMoodRecord(
          mood: Sinnsstemning.energisk,
          timestamp: DateTime(2026, 6, 23, 13, 49),
        ),
        HistoryMoodRecord(
          mood: Sinnsstemning.energisk,
          timestamp: DateTime(2026, 6, 23, 13, 50),
        ),
      ];

      final summary = DayHistorySummary(
        dayStart: DateTime(2026, 6, 23),
        completedTaskCount: 3,
        attemptCount: 3,
        notCompletedAttemptCount: 0,
        interruptedAttemptCount: 0,
        moodEntryCount: 4,
        moodCounts: const {Sinnsstemning.energisk: 4},
        eventMarkers: const <HistoryEventMarker>[],
        activityMoments: const <DateTime>[],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: DayDetailView(day: day, summary: summary, entries: entries),
        ),
      );

      expect(
        find.textContaining('Kjør en sporty økt med intervaller. ×3'),
        findsOneWidget,
      );
      expect(find.textContaining('Energisk ×4'), findsOneWidget);
      expect(find.textContaining('energisk ('), findsNothing);
    },
  );

  testWidgets('maps technical event ids and limits long section lists', (
    WidgetTester tester,
  ) async {
    final day = DateTime(2026, 6, 24);

    final entries = <HistoryEntry>[
      for (int i = 0; i < 9; i++)
        HistoryAttemptRecord(
          taskId: 'task-$i',
          focusAreaId: 'study',
          outcome: HistoryAttemptOutcome.completed,
          mood: Sinnsstemning.ok,
          timestamp: DateTime(2026, 6, 24, 10, i),
          taskTitleSnapshot: 'Oppgave ${i + 1}',
        ),
      HistoryEventRecord(
        eventId: 'event_user_name',
        action: HistoryEventAction.saved,
        timestamp: DateTime(2026, 6, 24, 11, 0),
        label: 'event_user_name',
      ),
      HistoryEventRecord(
        eventId: 'event_companion_name',
        action: HistoryEventAction.saved,
        timestamp: DateTime(2026, 6, 24, 11, 5),
        label: 'event_companion_name',
      ),
    ];

    final summary = DayHistorySummary(
      dayStart: DateTime(2026, 6, 24),
      completedTaskCount: 9,
      attemptCount: 9,
      notCompletedAttemptCount: 0,
      interruptedAttemptCount: 0,
      moodEntryCount: 0,
      moodCounts: const {},
      eventMarkers: const <HistoryEventMarker>[],
      activityMoments: const <DateTime>[],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: DayDetailView(day: day, summary: summary, entries: entries),
      ),
    );

    expect(find.textContaining('Navnet ditt ble lagret - lagret'), findsOneWidget);
    expect(find.textContaining('Figuren fikk navn - lagret'), findsOneWidget);
    expect(find.textContaining('event_user_name'), findsNothing);
    expect(find.textContaining('event_companion_name'), findsNothing);
    expect(find.textContaining('+ 2 flere spor denne dagen'), findsOneWidget);
  });
}
