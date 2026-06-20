import 'package:companion_app/core/models/attempt_entry.dart';
import 'package:companion_app/core/models/sinnsstemning.dart';

enum HistoryEntryType { attempt, mood, event }

enum HistoryAttemptOutcome { completed, notCompleted, interrupted }

enum HistoryEventAction { triggered, skipped, saved }

abstract class HistoryEntry {
  const HistoryEntry({required this.timestamp});

  final DateTime timestamp;

  HistoryEntryType get type;
}

class HistoryAttemptRecord extends HistoryEntry {
  const HistoryAttemptRecord({
    required this.taskId,
    required this.focusAreaId,
    required this.outcome,
    required this.mood,
    required super.timestamp,
    this.taskTitleSnapshot,
    this.wasEnergiskChainFollowUp = false,
  });

  factory HistoryAttemptRecord.fromAttemptEntry(
    AttemptEntry entry, {
    String? taskTitleSnapshot,
    bool wasEnergiskChainFollowUp = false,
  }) {
    return HistoryAttemptRecord(
      taskId: entry.taskId,
      focusAreaId: entry.focusAreaId,
      outcome: entry.done
          ? HistoryAttemptOutcome.completed
          : HistoryAttemptOutcome.notCompleted,
      mood: entry.mood,
      timestamp: entry.timestamp,
      taskTitleSnapshot: taskTitleSnapshot,
      wasEnergiskChainFollowUp: wasEnergiskChainFollowUp,
    );
  }

  final String taskId;
  final String focusAreaId;
  final HistoryAttemptOutcome outcome;
  final Sinnsstemning mood;
  final String? taskTitleSnapshot;
  final bool wasEnergiskChainFollowUp;

  @override
  HistoryEntryType get type => HistoryEntryType.attempt;
}

class HistoryMoodRecord extends HistoryEntry {
  const HistoryMoodRecord({
    required this.mood,
    required super.timestamp,
    this.focusAreaId,
  });

  final Sinnsstemning mood;
  final String? focusAreaId;

  @override
  HistoryEntryType get type => HistoryEntryType.mood;
}

class HistoryEventRecord extends HistoryEntry {
  const HistoryEventRecord({
    required this.eventId,
    required this.action,
    required super.timestamp,
    this.label,
  });

  final String eventId;
  final HistoryEventAction action;
  final String? label;

  @override
  HistoryEntryType get type => HistoryEntryType.event;
}
