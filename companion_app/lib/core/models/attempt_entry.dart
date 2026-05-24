import 'package:companion_app/core/models/sinnsstemning.dart';

class AttemptEntry {
  const AttemptEntry({
    required this.taskId,
    required this.focusAreaId,
    required this.done,
    required this.mood,
    required this.timestamp,
  });

  final String taskId;
  final String focusAreaId;
  final bool done;
  final Sinnsstemning mood;
  final DateTime timestamp;
}
