import 'package:companion_app/core/events/companion_event.dart';
import 'package:companion_app/core/events/companion_event_definitions.dart';
import 'package:companion_app/core/events/companion_event_state_snapshot.dart';

class CompanionEventController {
  CompanionEventController({List<CompanionEvent>? eventDefinitions})
    : _eventDefinitions =
          eventDefinitions ?? CompanionEventDefinitions.orderedUnlocks;

  final List<CompanionEvent> _eventDefinitions;

  int _completedTaskCount = 0;
  CompanionEvent? _pendingEvent;

  final Set<String> _autoTriggeredEventIds = <String>{};
  final Set<String> _handledEventIds = <String>{};
  final Set<String> _skippedEventIds = <String>{};

  int get completedTaskCount => _completedTaskCount;

  CompanionEvent? get pendingEvent => _pendingEvent;

  bool get hasPendingEvent => _pendingEvent != null;

  bool isEventAutoTriggered(String eventId) {
    return _autoTriggeredEventIds.contains(eventId);
  }

  bool isEventHandled(String eventId) {
    return _handledEventIds.contains(eventId);
  }

  bool isEventSkipped(String eventId) {
    return _skippedEventIds.contains(eventId);
  }

  bool isEventUnlocked(String eventId) {
    final event = _eventDefinitions.where((entry) => entry.id == eventId);
    if (event.isEmpty) {
      return false;
    }
    return _completedTaskCount >= event.first.threshold;
  }

  void onTaskResult({required bool done}) {
    if (done) {
      _completedTaskCount += 1;
    }

    _evaluatePendingUnlock();
  }

  void markPendingEventHandled({required bool skipped}) {
    final event = _pendingEvent;
    if (event == null) {
      return;
    }

    _handledEventIds.add(event.id);
    if (skipped) {
      _skippedEventIds.add(event.id);
    }

    _pendingEvent = null;
    _evaluatePendingUnlock();
  }

  void restoreHandledEvent({required String eventId, required bool skipped}) {
    _autoTriggeredEventIds.add(eventId);
    _handledEventIds.add(eventId);
    if (skipped) {
      _skippedEventIds.add(eventId);
    }

    if (_pendingEvent?.id == eventId) {
      _pendingEvent = null;
    }

    _evaluatePendingUnlock();
  }

  CompanionEventStateSnapshot toSnapshot() {
    return CompanionEventStateSnapshot(
      completedTaskCount: _completedTaskCount,
      autoTriggeredEventIds: Set<String>.from(_autoTriggeredEventIds),
      handledEventIds: Set<String>.from(_handledEventIds),
      skippedEventIds: Set<String>.from(_skippedEventIds),
      pendingEventId: _pendingEvent?.id,
    );
  }

  void restoreFromSnapshot(CompanionEventStateSnapshot snapshot) {
    _completedTaskCount = snapshot.completedTaskCount;

    _autoTriggeredEventIds
      ..clear()
      ..addAll(snapshot.autoTriggeredEventIds);

    _handledEventIds
      ..clear()
      ..addAll(snapshot.handledEventIds);

    _skippedEventIds
      ..clear()
      ..addAll(snapshot.skippedEventIds);

    _pendingEvent = null;
    final pendingId = snapshot.pendingEventId;
    if (pendingId != null) {
      for (final event in _eventDefinitions) {
        if (event.id == pendingId) {
          _pendingEvent = event;
          break;
        }
      }
    }

    if (_pendingEvent == null) {
      _evaluatePendingUnlock();
    }
  }

  void consumeDeferredAudioPendingEvents() {
    while (true) {
      final pendingId = _pendingEvent?.id;
      if (pendingId == null ||
          !CompanionEventDefinitions.isDeferredAudioEvent(pendingId)) {
        return;
      }

      markPendingEventHandled(skipped: true);
    }
  }

  void _evaluatePendingUnlock() {
    if (_pendingEvent != null) {
      return;
    }

    for (final event in _eventDefinitions) {
      final hasReachedThreshold = _completedTaskCount >= event.threshold;
      if (!hasReachedThreshold) {
        continue;
      }

      if (_autoTriggeredEventIds.contains(event.id)) {
        continue;
      }

      _pendingEvent = event;
      _autoTriggeredEventIds.add(event.id);
      return;
    }
  }
}
