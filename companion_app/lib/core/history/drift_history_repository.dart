import 'dart:async';

import 'package:companion_app/core/database/app_database.dart';
import 'package:companion_app/core/history/day_history_summary.dart';
import 'package:companion_app/core/history/history_aggregator.dart';
import 'package:companion_app/core/history/history_entry.dart';
import 'package:companion_app/core/history/history_repository.dart';
import 'package:companion_app/core/models/sinnsstemning.dart';
import 'package:drift/drift.dart' as drift;

class DriftHistoryRepository implements HistoryRepository {
  DriftHistoryRepository(this._database, {HistoryAggregator? aggregator})
    : _aggregator = aggregator ?? const HistoryAggregator();

  final AppDatabase _database;
  final HistoryAggregator _aggregator;

  final List<HistoryEntry> _entries = <HistoryEntry>[];
  final List<Future<void>> _pendingWriteOperations = <Future<void>>[];

  Future<void> initialize() async {
    final rows = await (_database.select(_database.historyEntries)
          ..orderBy([(table) => drift.OrderingTerm.asc(table.timestampMs)]))
        .get();

    _entries
      ..clear()
      ..addAll(rows.map(_mapRowToEntry));
  }

  @override
  void appendEntry(HistoryEntry entry) {
    _entries.add(entry);
    _entries.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    _trackPendingWrite(
      _database.into(_database.historyEntries).insert(_mapEntryToCompanion(entry)),
    );
  }

  @override
  void appendEntries(Iterable<HistoryEntry> entries) {
    final collected = entries.toList(growable: false);
    if (collected.isEmpty) {
      return;
    }

    _entries.addAll(collected);
    _entries.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    _trackPendingWrite(
      _database.batch((batch) {
        batch.insertAll(
          _database.historyEntries,
          collected.map(_mapEntryToCompanion).toList(growable: false),
        );
      }),
    );
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
    _trackPendingWrite(_database.delete(_database.historyEntries).go());
  }

  Future<void> flushPendingWritesForTest() async {
    if (_pendingWriteOperations.isEmpty) {
      return;
    }

    await Future.wait(List<Future<void>>.from(_pendingWriteOperations));
  }

  Future<void> close() async {
    await _database.close();
  }

  void _trackPendingWrite(Future<dynamic> writeOperation) {
    final trackedOperation = writeOperation.then((_) {});
    _pendingWriteOperations.add(trackedOperation);
    trackedOperation.whenComplete(() {
      _pendingWriteOperations.remove(trackedOperation);
    });
  }

  HistoryEntriesCompanion _mapEntryToCompanion(HistoryEntry entry) {
    final timestampMs = entry.timestamp.millisecondsSinceEpoch;

    if (entry is HistoryAttemptRecord) {
      return HistoryEntriesCompanion.insert(
        timestampMs: timestampMs,
        entryType: entry.type.name,
        taskId: drift.Value(entry.taskId),
        taskTitleSnapshot: drift.Value(entry.taskTitleSnapshot),
        focusAreaId: drift.Value(entry.focusAreaId),
        attemptOutcome: drift.Value(entry.outcome.name),
        mood: drift.Value(entry.mood.name),
        wasEnergiskChainFollowUp: drift.Value(entry.wasEnergiskChainFollowUp),
      );
    }

    if (entry is HistoryMoodRecord) {
      return HistoryEntriesCompanion.insert(
        timestampMs: timestampMs,
        entryType: entry.type.name,
        mood: drift.Value(entry.mood.name),
        focusAreaId: drift.Value(entry.focusAreaId),
      );
    }

    if (entry is HistoryEventRecord) {
      return HistoryEntriesCompanion.insert(
        timestampMs: timestampMs,
        entryType: entry.type.name,
        eventId: drift.Value(entry.eventId),
        eventAction: drift.Value(entry.action.name),
        eventLabel: drift.Value(entry.label),
      );
    }

    return HistoryEntriesCompanion.insert(
      timestampMs: timestampMs,
      entryType: entry.type.name,
    );
  }

  HistoryEntry _mapRowToEntry(HistoryEntryRow row) {
    final timestamp = DateTime.fromMillisecondsSinceEpoch(row.timestampMs);

    switch (row.entryType) {
      case 'attempt':
        return HistoryAttemptRecord(
          taskId: row.taskId ?? '',
          focusAreaId: row.focusAreaId ?? '',
          outcome: _attemptOutcomeFromName(row.attemptOutcome),
          mood: _moodFromName(row.mood),
          timestamp: timestamp,
          taskTitleSnapshot: row.taskTitleSnapshot,
          wasEnergiskChainFollowUp: row.wasEnergiskChainFollowUp,
        );
      case 'mood':
        return HistoryMoodRecord(
          mood: _moodFromName(row.mood),
          timestamp: timestamp,
          focusAreaId: row.focusAreaId,
        );
      case 'event':
        return HistoryEventRecord(
          eventId: row.eventId ?? '',
          action: _eventActionFromName(row.eventAction),
          timestamp: timestamp,
          label: row.eventLabel,
        );
      default:
        return HistoryEventRecord(
          eventId: row.eventId ?? 'unknown_event',
          action: _eventActionFromName(row.eventAction),
          timestamp: timestamp,
          label: row.eventLabel,
        );
    }
  }

  Sinnsstemning _moodFromName(String? mood) {
    switch (mood) {
      case 'negativ':
        return Sinnsstemning.negativ;
      case 'energisk':
        return Sinnsstemning.energisk;
      case 'ok':
      default:
        return Sinnsstemning.ok;
    }
  }

  HistoryAttemptOutcome _attemptOutcomeFromName(String? outcome) {
    switch (outcome) {
      case 'completed':
        return HistoryAttemptOutcome.completed;
      case 'interrupted':
        return HistoryAttemptOutcome.interrupted;
      case 'notCompleted':
      default:
        return HistoryAttemptOutcome.notCompleted;
    }
  }

  HistoryEventAction _eventActionFromName(String? action) {
    switch (action) {
      case 'triggered':
        return HistoryEventAction.triggered;
      case 'skipped':
        return HistoryEventAction.skipped;
      case 'saved':
      default:
        return HistoryEventAction.saved;
    }
  }
}
