import 'package:companion_app/core/history/day_history_summary.dart';
import 'package:companion_app/core/history/history_aggregator.dart';
import 'package:companion_app/core/history/history_entry.dart';
import 'package:companion_app/core/history/history_repository.dart';

class InMemoryHistoryRepository implements HistoryRepository {
  InMemoryHistoryRepository({HistoryAggregator? aggregator})
    : _aggregator = aggregator ?? const HistoryAggregator();

  final HistoryAggregator _aggregator;
  final List<HistoryEntry> _entries = <HistoryEntry>[];

  @override
  void appendEntry(HistoryEntry entry) {
    _entries.add(entry);
  }

  @override
  void appendEntries(Iterable<HistoryEntry> entries) {
    _entries.addAll(entries);
  }

  @override
  List<HistoryEntry> readEntriesInRange({
    required DateTime rangeStart,
    required DateTime rangeEndExclusive,
  }) {
    final entries = _entries
        .where(
          (entry) =>
              !entry.timestamp.isBefore(rangeStart) &&
              entry.timestamp.isBefore(rangeEndExclusive),
        )
        .toList(growable: false);

    entries.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return entries;
  }

  @override
  List<HistoryEntry> readEntriesForDay(DateTime day) {
    final dayStart = DateTime(day.year, day.month, day.day);
    final dayEndExclusive = dayStart.add(const Duration(days: 1));
    return readEntriesInRange(
      rangeStart: dayStart,
      rangeEndExclusive: dayEndExclusive,
    );
  }

  @override
  List<DayHistorySummary> readDaySummaries({
    required DateTime startDate,
    required int dayCount,
    bool includeEmptyDays = true,
  }) {
    return _aggregator.buildDaySummaries(
      entries: _entries,
      startDate: startDate,
      dayCount: dayCount,
      includeEmptyDays: includeEmptyDays,
    );
  }

  @override
  void clear() {
    _entries.clear();
  }
}
