import 'package:companion_app/core/events/companion_event_controller.dart';
import 'package:companion_app/core/events/companion_event_definitions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CompanionEventController', () {
    test('Ja increments completed task count', () {
      final controller = CompanionEventController();

      controller.onTaskResult(done: true);
      controller.onTaskResult(done: true);

      expect(controller.completedTaskCount, 2);
    });

    test('Nei does not increment completed task count', () {
      final controller = CompanionEventController();

      controller.onTaskResult(done: false);
      controller.onTaskResult(done: false);

      expect(controller.completedTaskCount, 0);
      expect(controller.pendingEvent, isNull);
    });

    test('event does not trigger before threshold', () {
      final controller = CompanionEventController();

      controller.onTaskResult(done: true);
      controller.onTaskResult(done: true);

      expect(controller.completedTaskCount, 2);
      expect(controller.pendingEvent, isNull);
      expect(
        controller.isEventAutoTriggered(
          CompanionEventDefinitions.companionNameId,
        ),
        isFalse,
      );
    });

    test('companion name event triggers exactly at 3 completions', () {
      final controller = CompanionEventController();

      controller.onTaskResult(done: true);
      controller.onTaskResult(done: true);
      controller.onTaskResult(done: true);

      final pending = controller.pendingEvent;
      expect(pending, isNotNull);
      expect(pending!.id, CompanionEventDefinitions.companionNameId);
      expect(
        controller.isEventAutoTriggered(
          CompanionEventDefinitions.companionNameId,
        ),
        isTrue,
      );
    });

    test('automatic trigger is one-time for a given event id', () {
      final controller = CompanionEventController();

      controller.onTaskResult(done: true);
      controller.onTaskResult(done: true);
      controller.onTaskResult(done: true);

      expect(
        controller.pendingEvent?.id,
        CompanionEventDefinitions.companionNameId,
      );

      controller.markPendingEventHandled(skipped: true);
      expect(controller.pendingEvent, isNull);

      controller.onTaskResult(done: true);
      controller.onTaskResult(done: true);

      expect(controller.completedTaskCount, 5);
      expect(controller.pendingEvent, isNull);
      expect(
        controller.isEventHandled(CompanionEventDefinitions.companionNameId),
        isTrue,
      );
      expect(
        controller.isEventSkipped(CompanionEventDefinitions.companionNameId),
        isTrue,
      );
    });

    test('pending event is cleared after save and does not repeat', () {
      final controller = CompanionEventController();

      controller.onTaskResult(done: true);
      controller.onTaskResult(done: true);
      controller.onTaskResult(done: true);

      expect(
        controller.pendingEvent?.id,
        CompanionEventDefinitions.companionNameId,
      );

      controller.markPendingEventHandled(skipped: false);

      expect(controller.pendingEvent, isNull);
      expect(controller.hasPendingEvent, isFalse);
      expect(
        controller.isEventHandled(CompanionEventDefinitions.companionNameId),
        isTrue,
      );
      expect(
        controller.isEventSkipped(CompanionEventDefinitions.companionNameId),
        isFalse,
      );

      controller.onTaskResult(done: true);
      controller.onTaskResult(done: true);

      expect(controller.completedTaskCount, 5);
      expect(controller.pendingEvent, isNull);
    });

    test('next event can trigger after previous pending is handled', () {
      final controller = CompanionEventController();

      for (int i = 0; i < 3; i++) {
        controller.onTaskResult(done: true);
      }
      controller.markPendingEventHandled(skipped: false);

      for (int i = 0; i < 3; i++) {
        controller.onTaskResult(done: true);
      }

      expect(controller.completedTaskCount, 6);
      expect(controller.pendingEvent?.id, CompanionEventDefinitions.userNameId);
    });

    test('energisk-chain Ja tasks count individually', () {
      final controller = CompanionEventController();

      controller.onTaskResult(done: true);
      controller.onTaskResult(done: true);

      expect(controller.completedTaskCount, 2);
      expect(controller.pendingEvent, isNull);

      controller.onTaskResult(done: true);

      expect(controller.completedTaskCount, 3);
      expect(
        controller.pendingEvent?.id,
        CompanionEventDefinitions.companionNameId,
      );
    });

    test('consumeDeferredAudioPendingEvents skips only background music', () {
      final controller = CompanionEventController();

      for (int i = 0; i < 18; i++) {
        controller.onTaskResult(done: true);
      }
      controller.markPendingEventHandled(skipped: false); // 3
      controller.markPendingEventHandled(skipped: false); // 6

      expect(
        controller.pendingEvent?.id,
        CompanionEventDefinitions.sleepSoundId,
      );

      controller.markPendingEventHandled(skipped: false);

      expect(
        controller.pendingEvent?.id,
        CompanionEventDefinitions.backgroundMusicId,
      );

      controller.consumeDeferredAudioPendingEvents();

      expect(
        controller.isEventSkipped(CompanionEventDefinitions.backgroundMusicId),
        isTrue,
      );

      expect(controller.pendingEvent?.id, CompanionEventDefinitions.symbolId);

      controller.markPendingEventHandled(skipped: false);
      expect(
        controller.pendingEvent?.id,
        CompanionEventDefinitions.backgroundColorId,
      );
      expect(
        controller.isEventHandled(CompanionEventDefinitions.symbolId),
        isTrue,
      );
    });

    test('deferred-audio consumption unblocks later symbol event', () {
      final controller = CompanionEventController();

      for (int i = 0; i < 15; i++) {
        controller.onTaskResult(done: true);
      }

      controller.markPendingEventHandled(skipped: false); // 3
      controller.markPendingEventHandled(skipped: false); // 6

      expect(
        controller.pendingEvent?.id,
        CompanionEventDefinitions.sleepSoundId,
      );
      controller.markPendingEventHandled(skipped: false);
      expect(
        controller.pendingEvent?.id,
        CompanionEventDefinitions.backgroundMusicId,
      );
      controller.consumeDeferredAudioPendingEvents();
      expect(controller.pendingEvent?.id, CompanionEventDefinitions.symbolId);
    });

    test(
      'restored handled events unlock next pending event from count replay',
      () {
        final controller = CompanionEventController();

        for (int i = 0; i < 6; i++) {
          controller.onTaskResult(done: true);
        }

        expect(
          controller.pendingEvent?.id,
          CompanionEventDefinitions.companionNameId,
        );

        controller.restoreHandledEvent(
          eventId: CompanionEventDefinitions.companionNameId,
          skipped: false,
        );

        expect(
          controller.pendingEvent?.id,
          CompanionEventDefinitions.userNameId,
        );

        controller.restoreHandledEvent(
          eventId: CompanionEventDefinitions.userNameId,
          skipped: true,
        );

        expect(controller.pendingEvent, isNull);
        expect(
          controller.isEventHandled(CompanionEventDefinitions.userNameId),
          isTrue,
        );
        expect(
          controller.isEventSkipped(CompanionEventDefinitions.userNameId),
          isTrue,
        );
      },
    );

    test('snapshot round-trip restores completed count and pending event', () {
      final controller = CompanionEventController();

      for (int i = 0; i < 3; i++) {
        controller.onTaskResult(done: true);
      }
      controller.markPendingEventHandled(skipped: false);

      for (int i = 0; i < 3; i++) {
        controller.onTaskResult(done: true);
      }

      final snapshot = controller.toSnapshot();
      final restored = CompanionEventController();
      restored.restoreFromSnapshot(snapshot);

      expect(restored.completedTaskCount, 6);
      expect(restored.pendingEvent?.id, CompanionEventDefinitions.userNameId);
      expect(
        restored.isEventHandled(CompanionEventDefinitions.companionNameId),
        isTrue,
      );
    });
  });
}
