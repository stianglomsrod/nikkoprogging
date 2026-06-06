import 'package:companion_app/core/flow/energisk_chain_controller.dart';
import 'package:companion_app/core/models/sinnsstemning.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EnergiskChainController', () {
    test('first energisk does not start chain', () {
      final controller = EnergiskChainController();

      controller.onMoodSelected(Sinnsstemning.energisk);

      expect(controller.consecutiveEnergiskMoodCount, 1);
      expect(controller.shouldStartChain, isFalse);
      expect(controller.isChainActive, isFalse);
    });

    test('second consecutive energisk starts chain condition', () {
      final controller = EnergiskChainController();

      controller.onMoodSelected(Sinnsstemning.energisk);
      controller.onMoodSelected(Sinnsstemning.energisk);

      expect(controller.consecutiveEnergiskMoodCount, 2);
      expect(controller.shouldStartChain, isTrue);
    });

    test(
      'non-energisk mood resets consecutive count and deactivates chain',
      () {
        final controller = EnergiskChainController();
        controller.onMoodSelected(Sinnsstemning.energisk);
        controller.onMoodSelected(Sinnsstemning.energisk);
        controller.activateChainWithFirstTask('task-1');

        controller.onMoodSelected(Sinnsstemning.ok);

        expect(controller.consecutiveEnergiskMoodCount, 0);
        expect(controller.isChainActive, isFalse);
        expect(controller.usedTaskIds, isEmpty);
      },
    );

    test('first chain task result advances to second chain task step', () {
      final controller = EnergiskChainController();
      controller.onMoodSelected(Sinnsstemning.energisk);
      controller.onMoodSelected(Sinnsstemning.energisk);
      controller.activateChainWithFirstTask('task-1');

      expect(controller.shouldSkipMoodPrompt, isTrue);
      controller.markFollowUpTaskStarted('task-2');

      expect(controller.shouldSkipMoodPrompt, isFalse);
      expect(controller.hasPendingFollowUpTask, isFalse);
      expect(controller.usedTaskIds, ['task-1', 'task-2']);
    });

    test(
      'second chain task completion resets chain via completeChainCycle',
      () {
        final controller = EnergiskChainController();
        controller.onMoodSelected(Sinnsstemning.energisk);
        controller.onMoodSelected(Sinnsstemning.energisk);
        controller.activateChainWithFirstTask('task-1');
        controller.markFollowUpTaskStarted('task-2');

        controller.completeChainCycle();

        expect(controller.isChainActive, isFalse);
        expect(controller.hasPendingFollowUpTask, isFalse);
        expect(controller.usedTaskIds, isEmpty);
        expect(controller.consecutiveEnergiskMoodCount, 0);
        expect(controller.shouldStartChain, isFalse);
      },
    );

    test('used task ids are tracked for non-repetition support', () {
      final controller = EnergiskChainController();
      controller.onMoodSelected(Sinnsstemning.energisk);
      controller.onMoodSelected(Sinnsstemning.energisk);

      controller.activateChainWithFirstTask('household_energisk_0');
      controller.markFollowUpTaskStarted('household_energisk_1');

      expect(controller.usedTaskIds, [
        'household_energisk_0',
        'household_energisk_1',
      ]);
    });

    test(
      'after reset, two new energisk moods are required to retrigger chain',
      () {
        final controller = EnergiskChainController();
        controller.onMoodSelected(Sinnsstemning.energisk);
        controller.onMoodSelected(Sinnsstemning.energisk);
        controller.activateChainWithFirstTask('task-1');
        controller.markFollowUpTaskStarted('task-2');
        controller.completeChainCycle();

        controller.onMoodSelected(Sinnsstemning.energisk);
        expect(controller.shouldStartChain, isFalse);

        controller.onMoodSelected(Sinnsstemning.energisk);
        expect(controller.shouldStartChain, isTrue);
      },
    );
  });
}
