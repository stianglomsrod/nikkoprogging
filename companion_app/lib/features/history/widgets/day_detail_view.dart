import 'package:companion_app/core/history/day_history_summary.dart';
import 'package:companion_app/core/history/history_entry.dart';
import 'package:companion_app/core/models/sinnsstemning.dart';
import 'package:companion_app/features/history/widgets/day_detail_section.dart';
import 'package:flutter/material.dart';

class DayDetailView extends StatelessWidget {
  const DayDetailView({
    super.key,
    required this.day,
    required this.summary,
    required this.entries,
  });

  final DateTime day;
  final DayHistorySummary summary;
  final List<HistoryEntry> entries;

  @override
  Widget build(BuildContext context) {
    final completedTaskIds = <String>[];
    final notCompletedTaskIds = <String>[];
    final interruptedTaskIds = <String>[];
    final moodLines = <String>[];
    final eventLines = <String>[];

    for (final entry in entries) {
      if (entry is HistoryAttemptRecord) {
        final attemptLabel = _attemptLabel(entry);
        switch (entry.outcome) {
          case HistoryAttemptOutcome.completed:
            completedTaskIds.add(attemptLabel);
            break;
          case HistoryAttemptOutcome.notCompleted:
            notCompletedTaskIds.add(attemptLabel);
            break;
          case HistoryAttemptOutcome.interrupted:
            interruptedTaskIds.add(attemptLabel);
            break;
        }
      } else if (entry is HistoryMoodRecord) {
        moodLines.add('${entry.mood.label} (${_formatTime(entry.timestamp)})');
      } else if (entry is HistoryEventRecord) {
        final label = entry.label ?? entry.eventId;
        eventLines.add('$label (${_eventActionLabel(entry.action)})');
      }
    }

    final activityTimes = summary.activityMoments
        .map(_formatTime)
        .toList(growable: false);
    final compactActivityTimes = _compactActivityTimes(activityTimes);

    final hasAnyActivity = entries.isNotEmpty || summary.hasActivity;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Detaljer for ${_formatDay(day)}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                IconButton(
                  tooltip: 'Lukk',
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              hasAnyActivity
                  ? 'Her er det du prøvde denne dagen.'
                  : 'Dette var en rolig dag. Her er det stille foreløpig.',
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: [
                  if (!hasAnyActivity)
                    DayDetailSection(
                      title: 'Rolig dag',
                      items: const [
                        'Noen dager er roligere.',
                        'Når du bruker appen, vil små spor dukke opp her.',
                      ],
                    ),
                  if (completedTaskIds.isNotEmpty)
                    DayDetailSection(
                      title: 'Fullførte oppgaver',
                      items: completedTaskIds,
                    ),
                  if (notCompletedTaskIds.isNotEmpty)
                    DayDetailSection(
                      title: 'Ikke fullførte oppgaver',
                      items: notCompletedTaskIds,
                    ),
                  if (interruptedTaskIds.isNotEmpty)
                    DayDetailSection(
                      title: 'Avbrutte oppgaver',
                      items: interruptedTaskIds,
                    ),
                  if (moodLines.isNotEmpty)
                    DayDetailSection(
                      title: 'Registrerte stemninger',
                      items: moodLines,
                    ),
                  if (eventLines.isNotEmpty)
                    DayDetailSection(title: 'Hendelser', items: eventLines),
                  if (compactActivityTimes.isNotEmpty)
                    DayDetailSection(
                      title: 'Tidspunkter med aktivitet',
                      items: compactActivityTimes,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _eventActionLabel(HistoryEventAction action) {
    switch (action) {
      case HistoryEventAction.triggered:
        return 'utløst';
      case HistoryEventAction.skipped:
        return 'hoppet over';
      case HistoryEventAction.saved:
        return 'lagret';
    }
  }

  String _formatDay(DateTime value) {
    final day = value.day.toString().padLeft(2, '0');
    final month = value.month.toString().padLeft(2, '0');
    return '$day.$month.${value.year}';
  }

  String _formatTime(DateTime value) {
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String _attemptLabel(HistoryAttemptRecord entry) {
    final snapshot = entry.taskTitleSnapshot?.trim();
    if (snapshot == null || snapshot.isEmpty) {
      return entry.taskId;
    }
    return snapshot;
  }

  List<String> _compactActivityTimes(List<String> times) {
    if (times.isEmpty) {
      return const <String>[];
    }

    final counts = <String, int>{};
    final order = <String>[];
    for (final time in times) {
      if (!counts.containsKey(time)) {
        order.add(time);
      }
      counts[time] = (counts[time] ?? 0) + 1;
    }

    const maxShown = 8;
    final shown = <String>[];
    for (final time in order.take(maxShown)) {
      final count = counts[time] ?? 1;
      shown.add(count > 1 ? '$time (x$count)' : time);
    }

    if (order.length > maxShown) {
      shown.add('Og ${order.length - maxShown} flere tidspunkter');
    }

    return shown;
  }
}
