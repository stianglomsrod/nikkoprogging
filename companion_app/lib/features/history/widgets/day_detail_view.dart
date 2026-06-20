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
    final completedTaskIdsRaw = <String>[];
    final notCompletedTaskIdsRaw = <String>[];
    final interruptedTaskIdsRaw = <String>[];
    final moodTimestamps = <Sinnsstemning, List<DateTime>>{};
    final moodOrder = <Sinnsstemning>[];
    final eventLinesRaw = <String>[];

    for (final entry in entries) {
      if (entry is HistoryAttemptRecord) {
        final attemptLabel = _attemptLabel(entry);
        switch (entry.outcome) {
          case HistoryAttemptOutcome.completed:
            completedTaskIdsRaw.add(attemptLabel);
            break;
          case HistoryAttemptOutcome.notCompleted:
            notCompletedTaskIdsRaw.add(attemptLabel);
            break;
          case HistoryAttemptOutcome.interrupted:
            interruptedTaskIdsRaw.add(attemptLabel);
            break;
        }
      } else if (entry is HistoryMoodRecord) {
        if (!moodTimestamps.containsKey(entry.mood)) {
          moodOrder.add(entry.mood);
          moodTimestamps[entry.mood] = <DateTime>[];
        }
        moodTimestamps[entry.mood]!.add(entry.timestamp);
      } else if (entry is HistoryEventRecord) {
        eventLinesRaw.add(_eventLine(entry));
      }
    }

    final completedTaskIds = _groupRepeatedLines(completedTaskIdsRaw);
    final notCompletedTaskIds = _groupRepeatedLines(notCompletedTaskIdsRaw);
    final interruptedTaskIds = _groupRepeatedLines(interruptedTaskIdsRaw);

    final moodLines = <String>[];
    for (final mood in moodOrder) {
      final timestamps = moodTimestamps[mood] ?? const <DateTime>[];
      if (timestamps.isEmpty) {
        continue;
      }
      moodLines.add(_moodSummaryLine(mood, timestamps));
    }

    final eventLines = _groupRepeatedLines(eventLinesRaw);

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

  String _eventLine(HistoryEventRecord entry) {
    final label = _eventDisplayLabel(entry.eventId, entry.label);
    return '$label - ${_eventActionLabel(entry.action)}';
  }

  String _eventDisplayLabel(String eventId, String? fallbackLabel) {
    const knownLabels = <String, String>{
      'event_companion_name': 'Figuren fikk navn',
      'event_user_name': 'Navnet ditt ble lagret',
      'event_symbol': 'Symbol ble valgt',
      'event_background_color': 'Bakgrunnsfarge ble valgt',
      'event_sleep_sound': 'Søvnlyd ble utsatt',
      'event_background_music': 'Bakgrunnslyd ble utsatt',
    };

    if (knownLabels.containsKey(eventId)) {
      return knownLabels[eventId]!;
    }

    final fallback = fallbackLabel?.trim();
    if (fallback != null &&
        fallback.isNotEmpty &&
        !fallback.startsWith('event_')) {
      return fallback;
    }

    final normalized = eventId.startsWith('event_')
        ? eventId.substring('event_'.length)
        : eventId;
    if (normalized.isEmpty) {
      return 'Hendelse';
    }

    final words = normalized
        .split('_')
        .where((part) => part.isNotEmpty)
        .map((part) {
          if (part.length == 1) {
            return part.toUpperCase();
          }
          return '${part[0].toUpperCase()}${part.substring(1)}';
        })
        .join(' ');
    return words.isEmpty ? 'Hendelse' : words;
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

  List<String> _groupRepeatedLines(List<String> lines) {
    if (lines.isEmpty) {
      return const <String>[];
    }

    final counts = <String, int>{};
    final order = <String>[];
    for (final line in lines) {
      if (!counts.containsKey(line)) {
        order.add(line);
      }
      counts[line] = (counts[line] ?? 0) + 1;
    }

    return order
        .map((line) {
          final count = counts[line] ?? 1;
          return count > 1 ? '$line ×$count' : line;
        })
        .toList(growable: false);
  }

  String _moodSummaryLine(Sinnsstemning mood, List<DateTime> timestamps) {
    final sorted = List<DateTime>.from(timestamps)
      ..sort((a, b) => a.compareTo(b));

    final label = _moodDisplayLabel(mood);
    if (sorted.length == 1) {
      return '$label (${_formatTime(sorted.first)})';
    }

    final first = _formatTime(sorted.first);
    final last = _formatTime(sorted.last);
    if (first == last) {
      return '$label ×${sorted.length}';
    }

    return '$label ×${sorted.length} ($first-$last)';
  }

  String _moodDisplayLabel(Sinnsstemning mood) {
    switch (mood) {
      case Sinnsstemning.negativ:
        return 'Tung';
      case Sinnsstemning.ok:
        return 'Ok';
      case Sinnsstemning.energisk:
        return 'Energisk';
    }
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
      shown.add(count > 1 ? '$time (×$count)' : time);
    }

    if (order.length > maxShown) {
      shown.add('Og ${order.length - maxShown} flere tidspunkter');
    }

    return shown;
  }
}
