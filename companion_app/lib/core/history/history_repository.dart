import 'package:companion_app/core/history/day_history_summary.dart';
import 'package:companion_app/core/history/history_entry.dart';

abstract class HistoryRepository {
  void appendEntry(HistoryEntry entry);

  void appendEntries(Iterable<HistoryEntry> entries);

  List<HistoryEntry> readEntriesInRange({
    required DateTime rangeStart,
    required DateTime rangeEndExclusive,
  });

  List<HistoryEntry> readEntriesForDay(DateTime day);

  List<DayHistorySummary> readDaySummaries({
    required DateTime startDate,
    required int dayCount,
    bool includeEmptyDays = true,
  });

  void clear();
}
