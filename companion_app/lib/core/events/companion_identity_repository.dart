import 'package:companion_app/core/events/companion_identity_state_snapshot.dart';

abstract class CompanionIdentityRepository {
  Future<CompanionIdentityStateSnapshot?> readState();

  Future<void> writeState(CompanionIdentityStateSnapshot snapshot);
}
