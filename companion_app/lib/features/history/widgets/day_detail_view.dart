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
        switch (entry.outcome) {
          case HistoryAttemptOutcome.completed:
            completedTaskIds.add(entry.taskId);
            break;
          case HistoryAttemptOutcome.notCompleted:
            notCompletedTaskIds.add(entry.taskId);
            break;
          case HistoryAttemptOutcome.interrupted:
            interruptedTaskIds.add(entry.taskId);
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
                  : 'Noen dager er roligere. Det er ingen registrert aktivitet her ennå.',
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: [
                  DayDetailSection(
                    title: 'Fullførte oppgaver',
                    items: completedTaskIds,
                    emptyText:
                        'Ingen fullførte oppgaver registrert denne dagen.',
                  ),
                  DayDetailSection(
                    title: 'Ikke fullførte oppgaver',
                    items: notCompletedTaskIds,
                    emptyText:
                        'Ingen ikke-fullførte oppgaver registrert denne dagen.',
                  ),
                  DayDetailSection(
                    title: 'Avbrutte oppgaver',
                    items: interruptedTaskIds,
                    emptyText:
                        'Ingen avbrutte oppgaver registrert denne dagen.',
                  ),
                  DayDetailSection(
                    title: 'Registrerte stemninger',
                    items: moodLines,
                    emptyText: 'Ingen stemninger registrert denne dagen.',
                  ),
                  DayDetailSection(
                    title: 'Hendelser',
                    items: eventLines,
                    emptyText: 'Ingen hendelser registrert denne dagen.',
                  ),
                  DayDetailSection(
                    title: 'Tidspunkter med aktivitet',
                    items: activityTimes,
                    emptyText:
                        'Ingen aktivitetstidspunkter registrert denne dagen.',
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
}
