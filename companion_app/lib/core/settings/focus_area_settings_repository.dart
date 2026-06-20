import 'package:companion_app/core/settings/focus_area_settings_state_snapshot.dart';

abstract class FocusAreaSettingsRepository {
  Future<FocusAreaSettingsStateSnapshot?> readState();

  Future<void> writeState(FocusAreaSettingsStateSnapshot snapshot);
}
