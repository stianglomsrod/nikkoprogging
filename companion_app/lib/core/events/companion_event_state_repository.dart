import 'package:companion_app/core/events/companion_event_state_snapshot.dart';

abstract class CompanionEventStateRepository {
  Future<CompanionEventStateSnapshot?> readState();

  Future<void> writeState(CompanionEventStateSnapshot snapshot);
}
