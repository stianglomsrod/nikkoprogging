import 'package:companion_app/core/models/modus.dart';

class ActiveTimeWindow {
  const ActiveTimeWindow({required this.startHour, required this.endHour});

  final int startHour;
  final int endHour;

  bool isActiveAtHour(int hour) {
    if (startHour <= endHour) {
      return hour >= startHour && hour < endHour;
    }
    return hour >= startHour || hour < endHour;
  }
}

class FocusArea {
  FocusArea({
    required this.id,
    required this.name,
    required this.enabled,
    required this.startHour,
    required this.endHour,
    required this.modus,
    this._activeWindows,
  });

  final String id;
  final String name;
  final bool enabled;
  final int startHour;
  final int endHour;
  final Modus modus;
  final List<ActiveTimeWindow>? _activeWindows;

  List<ActiveTimeWindow> get activeWindows {
    final windows = _activeWindows;
    if (windows == null || windows.isEmpty) {
      return <ActiveTimeWindow>[
        ActiveTimeWindow(startHour: startHour, endHour: endHour),
      ];
    }
    return windows;
  }

  bool isActiveAtHour(int hour) {
    return activeWindows.any((window) => window.isActiveAtHour(hour));
  }

  FocusArea copyWith({
    bool? enabled,
    int? startHour,
    int? endHour,
    Modus? modus,
    List<ActiveTimeWindow>? activeWindows,
  }) {
    final nextWindows =
        activeWindows ??
        _mergePrimaryWindow(
          activeWindows: this.activeWindows,
          startHour: startHour,
          endHour: endHour,
        );

    return FocusArea(
      id: id,
      name: name,
      enabled: enabled ?? this.enabled,
      startHour: nextWindows.first.startHour,
      endHour: nextWindows.first.endHour,
      modus: modus ?? this.modus,
      activeWindows: nextWindows,
    );
  }

  static List<ActiveTimeWindow> _mergePrimaryWindow({
    required List<ActiveTimeWindow> activeWindows,
    required int? startHour,
    required int? endHour,
  }) {
    final windows = List<ActiveTimeWindow>.from(activeWindows, growable: true);
    if (windows.isEmpty) {
      return <ActiveTimeWindow>[
        ActiveTimeWindow(startHour: startHour ?? 8, endHour: endHour ?? 22),
      ];
    }

    if (startHour == null && endHour == null) {
      return windows;
    }

    final current = windows.first;
    windows[0] = ActiveTimeWindow(
      startHour: startHour ?? current.startHour,
      endHour: endHour ?? current.endHour,
    );
    return windows;
  }
}
