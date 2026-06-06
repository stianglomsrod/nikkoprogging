import 'dart:collection';

import 'package:companion_app/core/models/sinnsstemning.dart';

class EnergiskChainController {
  int _consecutiveEnergiskMoodCount = 0;
  bool _chainActive = false;
  int _remainingChainTasks = 0;
  final List<String> _usedTaskIds = <String>[];

  int get consecutiveEnergiskMoodCount => _consecutiveEnergiskMoodCount;
  bool get isChainActive => _chainActive;
  bool get hasPendingFollowUpTask => _chainActive && _remainingChainTasks > 0;
  bool get shouldSkipMoodPrompt => hasPendingFollowUpTask;
  List<String> get usedTaskIds => UnmodifiableListView(_usedTaskIds);
  bool get shouldStartChain => _consecutiveEnergiskMoodCount >= 2;

  void onMoodSelected(Sinnsstemning mood) {
    if (mood == Sinnsstemning.energisk) {
      _consecutiveEnergiskMoodCount += 1;
      return;
    }

    _consecutiveEnergiskMoodCount = 0;
    deactivateChain();
  }

  void activateChainWithFirstTask(String taskId) {
    _chainActive = true;
    _remainingChainTasks = 1;
    _usedTaskIds
      ..clear()
      ..add(taskId);
  }

  void markFollowUpTaskStarted(String taskId) {
    if (!_chainActive) {
      return;
    }
    _usedTaskIds.add(taskId);
    if (_remainingChainTasks > 0) {
      _remainingChainTasks -= 1;
    }
  }

  void completeChainCycle() {
    deactivateChain();
    _consecutiveEnergiskMoodCount = 0;
  }

  void deactivateChain() {
    _chainActive = false;
    _remainingChainTasks = 0;
    _usedTaskIds.clear();
  }
}
