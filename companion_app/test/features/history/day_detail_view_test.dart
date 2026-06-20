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
    expect(find.text('Fullførte oppgaver'), findsOneWidget);
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
    expect(find.textContaining('Symbol valgt (lagret)'), findsOneWidget);
  });
}
