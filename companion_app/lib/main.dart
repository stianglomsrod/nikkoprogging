import 'package:companion_app/app/companion_app.dart';
import 'package:companion_app/core/database/app_database.dart';
import 'package:companion_app/core/events/drift_companion_identity_repository.dart';
import 'package:companion_app/core/events/drift_companion_event_state_repository.dart';
import 'package:companion_app/core/history/drift_history_repository.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = AppDatabase.openAtDefaultLocation();
  final historyRepository = DriftHistoryRepository(database);
  await historyRepository.initialize();
  final companionEventStateRepository = DriftCompanionEventStateRepository(
    database,
  );
  final initialCompanionEventState = await companionEventStateRepository
      .readState();
  final companionIdentityRepository = DriftCompanionIdentityRepository(
    database,
  );
  final initialCompanionIdentityState = await companionIdentityRepository
      .readState();

  runApp(
    CompanionApp(
      historyRepository: historyRepository,
      companionEventStateRepository: companionEventStateRepository,
      initialCompanionEventState: initialCompanionEventState,
      companionIdentityRepository: companionIdentityRepository,
      initialCompanionIdentityState: initialCompanionIdentityState,
    ),
  );
}
