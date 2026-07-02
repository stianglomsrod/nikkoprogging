import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:companion_app/app/app_config.dart';
import 'package:companion_app/core/content/companion_text_library.dart';
import 'package:companion_app/core/adaptive_engine/task_selector.dart';
import 'package:companion_app/core/events/companion_event_controller.dart';
import 'package:companion_app/core/events/companion_event_definitions.dart';
import 'package:companion_app/core/events/companion_identity_repository.dart';
import 'package:companion_app/core/events/companion_identity_state_snapshot.dart';
import 'package:companion_app/core/events/companion_identity.dart';
import 'package:companion_app/core/events/companion_event_state_repository.dart';
import 'package:companion_app/core/events/companion_event_state_snapshot.dart';
import 'package:companion_app/core/flow/energisk_chain_controller.dart';
import 'package:companion_app/core/feedback/feedback_repository.dart';
import 'package:companion_app/core/history/history_entry.dart';
import 'package:companion_app/core/history/history_repository.dart';
import 'package:companion_app/core/models/attempt_entry.dart';
import 'package:companion_app/core/models/focus_area.dart';
import 'package:companion_app/core/models/sinnsstemning.dart';
import 'package:companion_app/core/models/task_item.dart';
import 'package:companion_app/core/scheduler/scheduler_engine.dart';
import 'package:companion_app/core/seed_data/seed_data.dart';
import 'package:companion_app/core/settings/focus_area_settings_repository.dart';
import 'package:companion_app/core/settings/focus_area_settings_state_snapshot.dart';
import 'package:companion_app/features/feedback/feedback_action_button.dart';
import 'package:companion_app/features/history/history_screen.dart';
import 'package:companion_app/features/home/settings_page.dart';
import 'package:companion_app/features/home/widgets/background_music_event_view.dart';
import 'package:companion_app/features/home/widgets/background_color_event_view.dart';
import 'package:companion_app/features/home/widgets/bottom_action_area.dart';
import 'package:companion_app/features/home/widgets/companion_figure.dart';
import 'package:companion_app/features/home/widgets/companion_name_event_view.dart';
import 'package:companion_app/features/home/widgets/dialogue_box.dart';
import 'package:companion_app/features/home/widgets/home_layout_shell.dart';
import 'package:companion_app/features/home/widgets/idle_state_view.dart';
import 'package:companion_app/features/home/widgets/mood_state_view.dart';
import 'package:companion_app/features/home/widgets/result_state_view.dart';
import 'package:companion_app/features/home/widgets/sleep_sound_event_view.dart';
import 'package:companion_app/features/home/widgets/sleep_sound_feature_sheet.dart';
import 'package:companion_app/features/home/widgets/symbol_event_view.dart';
import 'package:companion_app/features/home/widgets/task_state_view.dart';
import 'package:companion_app/features/home/widgets/user_name_event_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum PromptStage {
  idle,
  mood,
  task,
  result,
  companionNameEvent,
  userNameEvent,
  sleepSoundEvent,
  backgroundMusicEvent,
  symbolEvent,
  backgroundColorEvent,
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.appConfig,
    required this.historyRepository,
    required this.feedbackRepository,
    required this.companionEventStateRepository,
    required this.companionIdentityRepository,
    required this.focusAreaSettingsRepository,
    this.feedbackScreenshotCapture,
    this.initialCompanionEventState,
    this.initialCompanionIdentityState,
    this.initialFocusAreaSettingsState,
  });

  final AppConfig appConfig;
  final HistoryRepository historyRepository;
  final FeedbackRepository feedbackRepository;
  final CompanionEventStateRepository companionEventStateRepository;
  final CompanionIdentityRepository companionIdentityRepository;
  final FocusAreaSettingsRepository focusAreaSettingsRepository;
  final FeedbackScreenshotCapture? feedbackScreenshotCapture;
  final CompanionEventStateSnapshot? initialCompanionEventState;
  final CompanionIdentityStateSnapshot? initialCompanionIdentityState;
  final FocusAreaSettingsStateSnapshot? initialFocusAreaSettingsState;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  static const Duration _happyAnimationDuration = Duration(milliseconds: 2200);
  static const Duration _autoPromptPollInterval = Duration(minutes: 1);

  final SchedulerEngine _scheduler = SchedulerEngine();
  final TaskSelector _selector = TaskSelector();
  final CompanionEventController _companionEvents = CompanionEventController();
  final AudioPlayer _sleepSoundPlayer = AudioPlayer();
  final AudioPlayer _backgroundMusicPlayer = AudioPlayer();
  final EnergiskChainController _energiskChain = EnergiskChainController();
  final Random _random = Random();
  final GlobalKey _feedbackCaptureKey = GlobalKey();

  late List<FocusArea> _focusAreas;
  late String _selectedSettingsAreaId;
  late final List<TaskItem> _allTasks;

  final Map<String, int> _promptsUsedPerArea = <String, int>{};
  final List<AttemptEntry> _attemptHistory = <AttemptEntry>[];
  final List<String> _recentFailedTaskIds = <String>[];

  int _simulatedHour = 18;
  PromptStage _stage = PromptStage.idle;

  FocusArea? _activeFocusArea;
  Sinnsstemning? _currentMood;
  TaskItem? _currentTask;
  String? _companionName;
  String? _userName;
  CompanionSleepSoundOption _sleepSound = CompanionSleepSoundOption.none;
  CompanionBackgroundMusicOption _backgroundMusic =
      CompanionBackgroundMusicOption.none;
  int _sleepSoundDurationMinutes = 15;
  CompanionSymbolOption _companionSymbol = CompanionSymbolOption.none;
  CompanionBackgroundTone _backgroundTone = CompanionBackgroundTone.defaultDark;
  String? _statusMessage;
  String? _resultMessage;
  CompanionAnimationState _companionAnimationState =
      CompanionAnimationState.idle;
  Timer? _happyResetTimer;
  Timer? _autoPromptTimer;
  Timer? _sleepSoundStopTimer;
  Timer? _sleepSoundProgressTicker;
  DateTime? _sleepSoundStopAt;
  Duration _sleepSoundSessionDuration = Duration.zero;
  bool _isBackgroundMusicPlaying = false;
  bool _backgroundMusicSyncScheduled = false;
  bool _isBackgroundMusicPreviewing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _focusAreas = _hydrateFocusAreasFromSettings(
      seeds: SeedData.focusAreas(),
      snapshot: widget.initialFocusAreaSettingsState,
    );
    _selectedSettingsAreaId = _resolveSelectedAreaId(
      areas: _focusAreas,
      preferred: widget.initialFocusAreaSettingsState?.selectedAreaId,
    );
    _allTasks = SeedData.tasks();
    final initialCompanionEventState = widget.initialCompanionEventState;
    if (initialCompanionEventState != null) {
      _companionEvents.restoreFromSnapshot(initialCompanionEventState);
    }

    final initialCompanionIdentityState = widget.initialCompanionIdentityState;
    if (initialCompanionIdentityState != null) {
      _companionName = initialCompanionIdentityState.companionName;
      _userName = initialCompanionIdentityState.userName;
      _sleepSound = initialCompanionIdentityState.sleepSound;
      _backgroundMusic = initialCompanionIdentityState.backgroundMusic;
      _companionSymbol = initialCompanionIdentityState.symbol;
      _backgroundTone = initialCompanionIdentityState.backgroundTone;
    }

    unawaited(_sleepSoundPlayer.setReleaseMode(ReleaseMode.loop));
    unawaited(_backgroundMusicPlayer.setReleaseMode(ReleaseMode.loop));

    if (widget.appConfig.autoPromptWhenIdle) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        _evaluateAutomaticPrompt(forceStatusRefresh: true);
        _startAutoPromptLoop();
      });
    }
  }

  List<FocusArea> _hydrateFocusAreasFromSettings({
    required List<FocusArea> seeds,
    FocusAreaSettingsStateSnapshot? snapshot,
  }) {
    if (snapshot == null || snapshot.areas.isEmpty) {
      return seeds;
    }

    final byId = {for (final area in snapshot.areas) area.id: area};

    return seeds
        .map((seed) {
          final saved = byId[seed.id];
          if (saved == null) {
            return seed;
          }
          return seed.copyWith(
            enabled: saved.enabled,
            startHour: saved.startHour,
            endHour: saved.endHour,
            activeWindows: saved.activeWindows,
            modus: saved.modus,
          );
        })
        .toList(growable: true);
  }

  String _resolveSelectedAreaId({
    required List<FocusArea> areas,
    required String? preferred,
  }) {
    if (preferred != null && areas.any((area) => area.id == preferred)) {
      return preferred;
    }
    return areas.first.id;
  }

  void _persistFocusAreaSettingsState() {
    widget.focusAreaSettingsRepository.writeState(
      FocusAreaSettingsStateSnapshot(
        areas: _focusAreas
            .map(
              (area) => FocusAreaSettingState(
                id: area.id,
                enabled: area.enabled,
                startHour: area.startHour,
                endHour: area.endHour,
                activeWindows: area.activeWindows,
                modus: area.modus,
              ),
            )
            .toList(growable: false),
        selectedAreaId: _selectedSettingsAreaId,
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _happyResetTimer?.cancel();
    _autoPromptTimer?.cancel();
    _sleepSoundStopTimer?.cancel();
    _sleepSoundProgressTicker?.cancel();
    unawaited(_backgroundMusicPlayer.dispose());
    unawaited(_sleepSoundPlayer.dispose());
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _resyncSleepSoundStopTimer();
      unawaited(_syncBackgroundMusicPlayback());
    }
  }

  int _currentSchedulerHour() {
    final override = widget.appConfig.currentHourOverride;
    if (override != null) {
      return override;
    }
    if (widget.appConfig.showPrototypeTimeControls) {
      return _simulatedHour;
    }
    return DateTime.now().hour;
  }

  void _startAutoPromptLoop() {
    _autoPromptTimer?.cancel();
    _autoPromptTimer = Timer.periodic(_autoPromptPollInterval, (_) {
      if (!mounted) {
        return;
      }
      _evaluateAutomaticPrompt();
    });
  }

  void _scheduleAutomaticPromptEvaluation({bool forceStatusRefresh = false}) {
    if (!widget.appConfig.autoPromptWhenIdle) {
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      _evaluateAutomaticPrompt(forceStatusRefresh: forceStatusRefresh);
    });
  }

  void _evaluateAutomaticPrompt({bool forceStatusRefresh = false}) {
    if (!widget.appConfig.autoPromptWhenIdle || _stage != PromptStage.idle) {
      return;
    }

    final area = _scheduler.selectEligibleFocusArea(
      focusAreas: _focusAreas,
      promptsUsed: _promptsUsedPerArea,
      currentHour: _currentSchedulerHour(),
    );

    if (area == null) {
      if (!forceStatusRefresh && _statusMessage != null) {
        return;
      }
      setState(() {
        _activeFocusArea = null;
        _currentMood = null;
        _currentTask = null;
        _statusMessage =
            'Hei. Fint å se deg. Jeg har ingen oppgaver til deg akkurat nå.';
        _resultMessage = null;
        _setCompanionToDefaultAnimation();
      });
      return;
    }

    setState(() {
      _activeFocusArea = area;
      _promptsUsedPerArea[area.id] = (_promptsUsedPerArea[area.id] ?? 0) + 1;
      _currentMood = null;
      _currentTask = null;
      _statusMessage = null;
      _resultMessage = null;
      _stage = PromptStage.mood;
      _setCompanionToDefaultAnimation();
    });
  }

  void _simulateNextPrompt() {
    setState(() {
      _statusMessage = null;
      _resultMessage = null;

      final area = _scheduler.selectEligibleFocusArea(
        focusAreas: _focusAreas,
        promptsUsed: _promptsUsedPerArea,
        currentHour: _currentSchedulerHour(),
      );

      if (area == null) {
        _stage = PromptStage.idle;
        _activeFocusArea = null;
        _currentMood = null;
        _currentTask = null;
        _statusMessage =
            'Hei. Fint å se deg. Jeg har ingen oppgaver til deg akkurat nå.';
        _setCompanionToDefaultAnimation();
        return;
      }

      _activeFocusArea = area;
      _promptsUsedPerArea[area.id] = (_promptsUsedPerArea[area.id] ?? 0) + 1;
      _currentMood = null;
      _currentTask = null;
      _stage = PromptStage.mood;
      _statusMessage = null;
      _setCompanionToDefaultAnimation();
    });
  }

  void _selectMood(Sinnsstemning mood) {
    final area = _activeFocusArea;
    if (area == null) {
      return;
    }

    _energiskChain.onMoodSelected(mood);
    final shouldStartChain = _energiskChain.shouldStartChain;
    final task = _selectTask(
      focusAreaId: area.id,
      mood: mood,
      blockedTaskIds: const <String>[],
    );

    setState(() {
      widget.historyRepository.appendEntry(
        HistoryMoodRecord(
          mood: mood,
          timestamp: DateTime.now(),
          focusAreaId: area.id,
        ),
      );

      if (shouldStartChain && task != null) {
        _energiskChain.activateChainWithFirstTask(task.id);
      } else if (shouldStartChain && task == null) {
        _energiskChain.completeChainCycle();
      } else {
        _energiskChain.deactivateChain();
      }

      _currentMood = mood;
      _currentTask = task;
      _stage = PromptStage.task;
      _setCompanionToDefaultAnimation();
      if (task == null) {
        _statusMessage = 'Fant ingen oppgave for ${area.name} akkurat nå.';
      }
    });
  }

  void _submitResult(bool done) {
    final area = _activeFocusArea;
    final mood = _currentMood;
    final task = _currentTask;
    if (area == null || mood == null || task == null) {
      return;
    }

    setState(() {
      final attemptEntry = AttemptEntry(
        taskId: task.id,
        focusAreaId: area.id,
        done: done,
        mood: mood,
        timestamp: DateTime.now(),
      );
      _attemptHistory.add(attemptEntry);
      widget.historyRepository.appendEntry(
        HistoryAttemptRecord.fromAttemptEntry(
          attemptEntry,
          taskTitleSnapshot: task.title,
        ),
      );
      _companionEvents.onTaskResult(done: done);
      _persistCompanionEventState();

      if (done) {
        _recentFailedTaskIds.remove(task.id);
      } else {
        _recentFailedTaskIds.remove(task.id);
        _recentFailedTaskIds.insert(0, task.id);
        if (_recentFailedTaskIds.length > 5) {
          _recentFailedTaskIds.removeLast();
        }
      }

      if (_energiskChain.shouldSkipMoodPrompt) {
        final nextTask = _selectTask(
          focusAreaId: area.id,
          mood: Sinnsstemning.energisk,
          blockedTaskIds: _energiskChain.usedTaskIds,
        );

        if (nextTask != null) {
          _currentTask = nextTask;
          _currentMood = Sinnsstemning.energisk;
          _energiskChain.markFollowUpTaskStarted(nextTask.id);
          _stage = PromptStage.task;
          _setCompanionToDefaultAnimation();
          return;
        }

        _energiskChain.completeChainCycle();
      }

      if (_energiskChain.isChainActive &&
          !_energiskChain.hasPendingFollowUpTask) {
        _energiskChain.completeChainCycle();
      }

      _resultMessage = _pickResultMessage(done);
      _stage = PromptStage.result;
      if (done) {
        _triggerHappyAnimation();
      } else {
        _setCompanionToDefaultAnimation();
      }
    });
  }

  bool _shouldShowSleepAnimation() {
    final sleepSoundSessionActive = _sleepSoundStopAt != null;
    return _stage == PromptStage.idle &&
        (_statusMessage != null || sleepSoundSessionActive);
  }

  CompanionAnimationState _defaultAnimationForState() {
    return _shouldShowSleepAnimation()
        ? CompanionAnimationState.sleep
        : CompanionAnimationState.idle;
  }

  void _setCompanionToDefaultAnimation() {
    _happyResetTimer?.cancel();
    _companionAnimationState = _defaultAnimationForState();
  }

  void _triggerHappyAnimation() {
    _happyResetTimer?.cancel();
    _companionAnimationState = CompanionAnimationState.happy;
    _happyResetTimer = Timer(_happyAnimationDuration, () {
      if (!mounted) {
        return;
      }
      setState(() {
        if (_companionAnimationState == CompanionAnimationState.happy) {
          _companionAnimationState = _defaultAnimationForState();
        }
      });
    });
  }

  TaskItem? _selectTask({
    required String focusAreaId,
    required Sinnsstemning mood,
    required List<String> blockedTaskIds,
  }) {
    final excluded = <String>{
      ..._recentFailedTaskIds,
      ...blockedTaskIds,
    }.toList(growable: false);

    return _selector.selectTask(
      focusAreaId: focusAreaId,
      mood: mood,
      allTasks: _allTasks,
      history: _attemptHistory,
      recentFailedTaskIds: excluded,
    );
  }

  String _pickResultMessage(bool done) {
    if (done) {
      final mood = _currentMood ?? Sinnsstemning.ok;
      return _pickFrom(
        CompanionTextLibrary.taskDoneYes[CompanionTextLibrary.moodKey(mood)]!,
      );
    }
    return _pickFrom(CompanionTextLibrary.taskDoneNo);
  }

  bool _hasPendingCompanionNameEvent() {
    return _companionEvents.pendingEvent?.id ==
        CompanionEventDefinitions.companionNameId;
  }

  bool _hasPendingUserNameEvent() {
    return _companionEvents.pendingEvent?.id ==
        CompanionEventDefinitions.userNameId;
  }

  bool _hasPendingSleepSoundEvent() {
    return _companionEvents.pendingEvent?.id ==
        CompanionEventDefinitions.sleepSoundId;
  }

  bool _hasPendingBackgroundMusicEvent() {
    return _companionEvents.pendingEvent?.id ==
        CompanionEventDefinitions.backgroundMusicId;
  }

  bool _hasPendingSymbolEvent() {
    return _companionEvents.pendingEvent?.id ==
        CompanionEventDefinitions.symbolId;
  }

  bool _hasPendingBackgroundColorEvent() {
    return _companionEvents.pendingEvent?.id ==
        CompanionEventDefinitions.backgroundColorId;
  }

  void _consumeDeferredAudioEvents() {
    while (true) {
      final pending = _companionEvents.pendingEvent;
      if (pending == null ||
          !CompanionEventDefinitions.isDeferredAudioEvent(pending.id)) {
        return;
      }

      widget.historyRepository.appendEntry(
        HistoryEventRecord(
          eventId: pending.id,
          action: HistoryEventAction.skipped,
          timestamp: DateTime.now(),
        ),
      );

      _companionEvents.markPendingEventHandled(skipped: true);
      _persistCompanionEventState();
    }
  }

  void _skipCompanionNameEvent() {
    setState(() {
      _recordPendingEventAction(HistoryEventAction.skipped);
      _companionEvents.markPendingEventHandled(skipped: true);
      _persistCompanionEventState();
      _stage = PromptStage.idle;
      _activeFocusArea = null;
      _currentMood = null;
      _currentTask = null;
      _statusMessage = null;
      _resultMessage = null;
      _setCompanionToDefaultAnimation();
    });

    _scheduleAutomaticPromptEvaluation();
  }

  void _saveCompanionName(String value) {
    final normalizedValue = value.trim();
    if (normalizedValue.isEmpty) {
      return;
    }

    setState(() {
      _companionName = normalizedValue;
      _recordPendingEventAction(HistoryEventAction.saved);
      _companionEvents.markPendingEventHandled(skipped: false);
      _persistCompanionEventState();
      _persistCompanionIdentityState();
      _stage = PromptStage.idle;
      _activeFocusArea = null;
      _currentMood = null;
      _currentTask = null;
      _statusMessage = null;
      _resultMessage = null;
      _setCompanionToDefaultAnimation();
    });

    _scheduleAutomaticPromptEvaluation(forceStatusRefresh: true);

    _scheduleAutomaticPromptEvaluation(forceStatusRefresh: true);
  }

  void _skipUserNameEvent() {
    setState(() {
      _recordPendingEventAction(HistoryEventAction.skipped);
      _companionEvents.markPendingEventHandled(skipped: true);
      _persistCompanionEventState();
      _stage = PromptStage.idle;
      _activeFocusArea = null;
      _currentMood = null;
      _currentTask = null;
      _statusMessage = null;
      _resultMessage = null;
      _setCompanionToDefaultAnimation();
    });

    _scheduleAutomaticPromptEvaluation(forceStatusRefresh: true);
  }

  Future<void> _previewSleepSound(CompanionSleepSoundOption option) async {
    final assetPath = option.assetPath;
    if (assetPath == null) {
      return;
    }

    await _safeStopSleepSoundPlayer();
    await _safePlaySleepSoundAsset(assetPath);
  }

  Future<void> _stopSleepSoundPreview() {
    return _safeStopSleepSoundPlayer();
  }

  Future<void> _safePlaySleepSoundAsset(String assetPath) async {
    try {
      await _sleepSoundPlayer.setReleaseMode(ReleaseMode.loop);
      await _sleepSoundPlayer.play(AssetSource(assetPath));
    } on MissingPluginException {
      // Audio plugins are not available in widget tests.
    }
  }

  Future<void> _safeStopSleepSoundPlayer() async {
    try {
      await _sleepSoundPlayer.stop();
    } on MissingPluginException {
      // Audio plugins are not available in widget tests.
    }
  }

  bool _shouldPlayBackgroundMusic() {
    return _stage == PromptStage.idle &&
        _backgroundMusic != CompanionBackgroundMusicOption.none &&
        _sleepSoundStopAt == null;
  }

  Future<void> _safePlayBackgroundMusicAsset(String assetPath) async {
    try {
      await _backgroundMusicPlayer.setReleaseMode(ReleaseMode.loop);
      await _backgroundMusicPlayer.play(AssetSource(assetPath));
    } on MissingPluginException {
      // Audio plugins are not available in widget tests.
    }
  }

  Future<void> _safeStopBackgroundMusicPlayer() async {
    try {
      await _backgroundMusicPlayer.stop();
    } on MissingPluginException {
      // Audio plugins are not available in widget tests.
    }
  }

  Future<void> _syncBackgroundMusicPlayback() async {
    if (_isBackgroundMusicPreviewing) {
      return;
    }

    final shouldPlay = _shouldPlayBackgroundMusic();
    if (shouldPlay) {
      if (_isBackgroundMusicPlaying) {
        return;
      }

      final assetPath = _backgroundMusic.assetPath;
      if (assetPath == null) {
        return;
      }

      await _safePlayBackgroundMusicAsset(assetPath);
      _isBackgroundMusicPlaying = true;
      return;
    }

    if (!_isBackgroundMusicPlaying) {
      return;
    }

    await _safeStopBackgroundMusicPlayer();
    _isBackgroundMusicPlaying = false;
  }

  Future<void> _previewBackgroundMusic(
    CompanionBackgroundMusicOption option,
  ) async {
    await _safeStopBackgroundMusicPlayer();
    _isBackgroundMusicPlaying = false;

    final assetPath = option.assetPath;
    if (assetPath == null) {
      _isBackgroundMusicPreviewing = false;
      return;
    }

    await _safePlayBackgroundMusicAsset(assetPath);
    _isBackgroundMusicPreviewing = true;
  }

  Future<void> _stopBackgroundMusicPreview() async {
    if (!_isBackgroundMusicPreviewing) {
      return;
    }

    await _safeStopBackgroundMusicPlayer();
    _isBackgroundMusicPreviewing = false;
    await _syncBackgroundMusicPlayback();
  }

  void _scheduleBackgroundMusicSync() {
    if (_backgroundMusicSyncScheduled) {
      return;
    }
    _backgroundMusicSyncScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _backgroundMusicSyncScheduled = false;
      if (!mounted) {
        return;
      }
      unawaited(_syncBackgroundMusicPlayback());
    });
  }

  void _applySleepFeatureSelection(
    CompanionSleepSoundOption sound,
    int durationMinutes,
  ) {
    setState(() {
      _sleepSound = sound;
      _sleepSoundDurationMinutes = durationMinutes;
      _persistCompanionIdentityState();
    });

    unawaited(
      _startTimedSleepSoundSession(
        sound: sound,
        duration: Duration(minutes: durationMinutes),
      ),
    );
  }

  Future<void> _startTimedSleepSoundSession({
    required CompanionSleepSoundOption sound,
    required Duration duration,
  }) async {
    _sleepSoundStopTimer?.cancel();
    _sleepSoundStopTimer = null;
    _sleepSoundProgressTicker?.cancel();
    if (mounted) {
      setState(() {
        _sleepSoundStopAt = null;
        _sleepSoundSessionDuration = Duration.zero;
      });
    } else {
      _sleepSoundStopAt = null;
      _sleepSoundSessionDuration = Duration.zero;
    }

    await _safeStopSleepSoundPlayer();

    final assetPath = sound.assetPath;
    if (assetPath == null) {
      return;
    }

    final stopAt = DateTime.now().add(duration);
    if (mounted) {
      setState(() {
        _sleepSoundStopAt = stopAt;
        _sleepSoundSessionDuration = duration;
        _setCompanionToDefaultAnimation();
      });
    } else {
      _sleepSoundStopAt = stopAt;
      _sleepSoundSessionDuration = duration;
    }

    _startSleepSoundProgressTicker();

    _sleepSoundStopTimer = Timer(duration, () {
      unawaited(_stopTimedSleepSoundSession());
    });

    await _safeStopBackgroundMusicPlayer();
    _isBackgroundMusicPlaying = false;

    await _safePlaySleepSoundAsset(assetPath);
  }

  Future<void> _stopTimedSleepSoundSession() async {
    _sleepSoundStopTimer?.cancel();
    _sleepSoundStopTimer = null;
    _sleepSoundProgressTicker?.cancel();
    _sleepSoundProgressTicker = null;
    if (mounted) {
      setState(() {
        _sleepSoundStopAt = null;
        _sleepSoundSessionDuration = Duration.zero;
        if (_companionAnimationState != CompanionAnimationState.happy) {
          _setCompanionToDefaultAnimation();
        }
      });
    } else {
      _sleepSoundStopAt = null;
      _sleepSoundSessionDuration = Duration.zero;
    }
    await _safeStopSleepSoundPlayer();
    await _syncBackgroundMusicPlayback();
  }

  void _startSleepSoundProgressTicker() {
    _sleepSoundProgressTicker?.cancel();
    if (_sleepSoundStopAt == null) {
      return;
    }

    _sleepSoundProgressTicker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) {
        return;
      }

      final stopAt = _sleepSoundStopAt;
      if (stopAt == null) {
        _sleepSoundProgressTicker?.cancel();
        _sleepSoundProgressTicker = null;
        return;
      }

      final remaining = stopAt.difference(DateTime.now());
      if (remaining <= Duration.zero) {
        unawaited(_stopTimedSleepSoundSession());
        return;
      }

      setState(() {});
    });
  }

  void _resyncSleepSoundStopTimer() {
    final stopAt = _sleepSoundStopAt;
    if (stopAt == null) {
      return;
    }

    final remaining = stopAt.difference(DateTime.now());
    if (remaining <= Duration.zero) {
      unawaited(_stopTimedSleepSoundSession());
      return;
    }

    _sleepSoundStopTimer?.cancel();
    _sleepSoundStopTimer = Timer(remaining, () {
      unawaited(_stopTimedSleepSoundSession());
    });

    _startSleepSoundProgressTicker();
  }

  bool _isSleepFeatureUnlocked() {
    return _companionEvents.isEventHandled(
      CompanionEventDefinitions.sleepSoundId,
    );
  }

  Future<void> _openSleepFeatureSheet() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SleepSoundFeatureSheet(
          initialSound: _sleepSound,
          initialDurationMinutes: _sleepSoundDurationMinutes,
          onPreview: (option) {
            unawaited(_previewSleepSound(option));
          },
          onStopPreview: () {
            unawaited(_stopSleepSoundPreview());
          },
          onSave: (sound, durationMinutes) {
            _applySleepFeatureSelection(sound, durationMinutes);
          },
        );
      },
    );
  }

  Duration? _remainingSleepSoundDuration() {
    final stopAt = _sleepSoundStopAt;
    if (stopAt == null) {
      return null;
    }

    final remaining = stopAt.difference(DateTime.now());
    if (remaining <= Duration.zero) {
      return Duration.zero;
    }
    return remaining;
  }

  double _sleepSoundProgress() {
    if (_sleepSoundSessionDuration <= Duration.zero) {
      return 0;
    }

    final remaining = _remainingSleepSoundDuration() ?? Duration.zero;
    final totalMs = _sleepSoundSessionDuration.inMilliseconds;
    if (totalMs <= 0) {
      return 0;
    }

    final remainingMs = remaining.inMilliseconds.clamp(0, totalMs);
    return ((totalMs - remainingMs) / totalMs).clamp(0, 1);
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    final secondsPadded = seconds.toString().padLeft(2, '0');
    return '$minutes:$secondsPadded';
  }

  Widget _buildSleepPlaybackPanel() {
    final remaining = _remainingSleepSoundDuration();
    if (remaining == null || _sleepSound == CompanionSleepSoundOption.none) {
      return const SizedBox.shrink();
    }

    final progress = _sleepSoundProgress();
    return Card(
      key: const ValueKey('sleep-player-panel'),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Søvnlyd aktiv (${_sleepSound.label})',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 6),
            Text('Gjenstår ${_formatDuration(remaining)}'),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              key: const ValueKey('sleep-player-progress'),
              value: progress,
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              key: const ValueKey('sleep-player-stop-button'),
              onPressed: () {
                unawaited(_stopTimedSleepSoundSession());
              },
              child: const Text('Skru av'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _wrapBottomActionWithSleepPlayer(Widget child) {
    final playerPanel = _buildSleepPlaybackPanel();
    if (playerPanel is SizedBox) {
      return child;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [playerPanel, const SizedBox(height: 8), child],
    );
  }

  Future<void> _openSleepFeatureFromEvent() async {
    setState(() {
      _recordPendingEventAction(HistoryEventAction.saved);
      _companionEvents.markPendingEventHandled(skipped: false);
      _persistCompanionEventState();
      _stage = PromptStage.idle;
      _activeFocusArea = null;
      _currentMood = null;
      _currentTask = null;
      _statusMessage = null;
      _resultMessage = null;
      _setCompanionToDefaultAnimation();
    });

    _consumeDeferredAudioEvents();
    await _openSleepFeatureSheet();
    if (!mounted) {
      return;
    }
    _scheduleAutomaticPromptEvaluation(forceStatusRefresh: true);
  }

  Future<void> _openBackgroundMusicSettingsFromEvent() async {
    setState(() {
      _recordPendingEventAction(HistoryEventAction.saved);
      _companionEvents.markPendingEventHandled(skipped: false);
      _persistCompanionEventState();
      _stage = PromptStage.idle;
      _activeFocusArea = null;
      _currentMood = null;
      _currentTask = null;
      _statusMessage = null;
      _resultMessage = null;
      _setCompanionToDefaultAnimation();
    });

    await _openSettings();
    if (!mounted) {
      return;
    }
    _scheduleAutomaticPromptEvaluation(forceStatusRefresh: true);
  }

  void _checkBackgroundMusicLater() {
    setState(() {
      _recordPendingEventAction(HistoryEventAction.skipped);
      _companionEvents.markPendingEventHandled(skipped: true);
      _persistCompanionEventState();
      _stage = PromptStage.idle;
      _activeFocusArea = null;
      _currentMood = null;
      _currentTask = null;
      _statusMessage = null;
      _resultMessage = null;
      _setCompanionToDefaultAnimation();
    });

    _scheduleAutomaticPromptEvaluation(forceStatusRefresh: true);
  }

  void _checkSleepFeatureLater() {
    setState(() {
      _recordPendingEventAction(HistoryEventAction.skipped);
      _companionEvents.markPendingEventHandled(skipped: true);
      _persistCompanionEventState();
      _stage = PromptStage.idle;
      _activeFocusArea = null;
      _currentMood = null;
      _currentTask = null;
      _statusMessage = null;
      _resultMessage = null;
      _setCompanionToDefaultAnimation();
    });

    _consumeDeferredAudioEvents();
    _scheduleAutomaticPromptEvaluation(forceStatusRefresh: true);
  }

  void _saveUserName(String value) {
    final normalizedValue = value.trim();
    if (normalizedValue.isEmpty) {
      return;
    }

    setState(() {
      _userName = normalizedValue;
      _recordPendingEventAction(HistoryEventAction.saved);
      _companionEvents.markPendingEventHandled(skipped: false);
      _persistCompanionEventState();
      _persistCompanionIdentityState();
      _stage = PromptStage.idle;
      _activeFocusArea = null;
      _currentMood = null;
      _currentTask = null;
      _statusMessage = null;
      _resultMessage = null;
      _setCompanionToDefaultAnimation();
    });

    _scheduleAutomaticPromptEvaluation(forceStatusRefresh: true);
  }

  void _skipSymbolEvent() {
    setState(() {
      _recordPendingEventAction(HistoryEventAction.skipped);
      _companionEvents.markPendingEventHandled(skipped: true);
      _persistCompanionEventState();
      _stage = PromptStage.idle;
      _activeFocusArea = null;
      _currentMood = null;
      _currentTask = null;
      _statusMessage = null;
      _resultMessage = null;
      _setCompanionToDefaultAnimation();
    });

    _scheduleAutomaticPromptEvaluation(forceStatusRefresh: true);
  }

  void _saveSymbol(CompanionSymbolOption symbol) {
    setState(() {
      _companionSymbol = symbol;
      _recordPendingEventAction(HistoryEventAction.saved);
      _companionEvents.markPendingEventHandled(skipped: false);
      _persistCompanionEventState();
      _persistCompanionIdentityState();
      _stage = PromptStage.idle;
      _activeFocusArea = null;
      _currentMood = null;
      _currentTask = null;
      _statusMessage = null;
      _resultMessage = null;
      _setCompanionToDefaultAnimation();
    });

    _scheduleAutomaticPromptEvaluation(forceStatusRefresh: true);
  }

  void _skipBackgroundColorEvent() {
    setState(() {
      _recordPendingEventAction(HistoryEventAction.skipped);
      _companionEvents.markPendingEventHandled(skipped: true);
      _persistCompanionEventState();
      _stage = PromptStage.idle;
      _activeFocusArea = null;
      _currentMood = null;
      _currentTask = null;
      _statusMessage = null;
      _resultMessage = null;
      _setCompanionToDefaultAnimation();
    });

    _scheduleAutomaticPromptEvaluation(forceStatusRefresh: true);
  }

  void _saveBackgroundTone(CompanionBackgroundTone tone) {
    setState(() {
      _backgroundTone = tone;
      _recordPendingEventAction(HistoryEventAction.saved);
      _companionEvents.markPendingEventHandled(skipped: false);
      _persistCompanionEventState();
      _persistCompanionIdentityState();
      _stage = PromptStage.idle;
      _activeFocusArea = null;
      _currentMood = null;
      _currentTask = null;
      _statusMessage = null;
      _resultMessage = null;
      _setCompanionToDefaultAnimation();
    });

    _scheduleAutomaticPromptEvaluation(forceStatusRefresh: true);
  }

  String _headerTitle() {
    final baseName = _companionName ?? '.....';
    final symbol = _companionSymbol.glyph;
    if (symbol == null || _companionName == null) {
      return baseName;
    }
    return '$symbol $baseName $symbol';
  }

  void _recordPendingEventAction(HistoryEventAction action) {
    final pending = _companionEvents.pendingEvent;
    if (pending == null) {
      return;
    }

    widget.historyRepository.appendEntry(
      HistoryEventRecord(
        eventId: pending.id,
        action: action,
        timestamp: DateTime.now(),
      ),
    );
  }

  void _persistCompanionEventState() {
    unawaited(
      widget.companionEventStateRepository.writeState(
        _companionEvents.toSnapshot(),
      ),
    );
  }

  void _persistCompanionIdentityState() {
    unawaited(
      widget.companionIdentityRepository.writeState(
        CompanionIdentityStateSnapshot(
          companionName: _companionName,
          userName: _userName,
          sleepSound: _sleepSound,
          backgroundMusic: _backgroundMusic,
          symbol: _companionSymbol,
          backgroundTone: _backgroundTone,
        ),
      ),
    );
  }

  void _resetToIdle() {
    _consumeDeferredAudioEvents();

    if (_stage == PromptStage.result && _hasPendingCompanionNameEvent()) {
      setState(() {
        _stage = PromptStage.companionNameEvent;
        _activeFocusArea = null;
        _currentMood = null;
        _currentTask = null;
        _statusMessage = null;
        _resultMessage = null;
        _setCompanionToDefaultAnimation();
      });
      return;
    }

    if (_stage == PromptStage.result && _hasPendingSleepSoundEvent()) {
      setState(() {
        _stage = PromptStage.sleepSoundEvent;
        _activeFocusArea = null;
        _currentMood = null;
        _currentTask = null;
        _statusMessage = null;
        _resultMessage = null;
        _setCompanionToDefaultAnimation();
      });
      return;
    }

    if (_stage == PromptStage.result && _hasPendingBackgroundMusicEvent()) {
      setState(() {
        _stage = PromptStage.backgroundMusicEvent;
        _activeFocusArea = null;
        _currentMood = null;
        _currentTask = null;
        _statusMessage = null;
        _resultMessage = null;
        _setCompanionToDefaultAnimation();
      });
      return;
    }

    if (_stage == PromptStage.result && _hasPendingSymbolEvent()) {
      setState(() {
        _stage = PromptStage.symbolEvent;
        _activeFocusArea = null;
        _currentMood = null;
        _currentTask = null;
        _statusMessage = null;
        _resultMessage = null;
        _setCompanionToDefaultAnimation();
      });
      return;
    }

    if (_stage == PromptStage.result && _hasPendingBackgroundColorEvent()) {
      setState(() {
        _stage = PromptStage.backgroundColorEvent;
        _activeFocusArea = null;
        _currentMood = null;
        _currentTask = null;
        _statusMessage = null;
        _resultMessage = null;
        _setCompanionToDefaultAnimation();
      });
      return;
    }

    if (_stage == PromptStage.result && _hasPendingUserNameEvent()) {
      setState(() {
        _stage = PromptStage.userNameEvent;
        _activeFocusArea = null;
        _currentMood = null;
        _currentTask = null;
        _statusMessage = null;
        _resultMessage = null;
        _setCompanionToDefaultAnimation();
      });
      return;
    }

    setState(() {
      _stage = PromptStage.idle;
      _activeFocusArea = null;
      _currentMood = null;
      _currentTask = null;
      _statusMessage = null;
      _resultMessage = null;
      _setCompanionToDefaultAnimation();
    });
  }

  Future<void> _openSettings() async {
    final result = await Navigator.of(context).push<SettingsResult>(
      MaterialPageRoute(
        builder: (_) => SettingsPage(
          feedbackRepository: widget.feedbackRepository,
          focusAreas: _focusAreas,
          initialSelectedAreaId: _selectedSettingsAreaId,
          simulatedHour: _simulatedHour,
          showPrototypeTimeControls: widget.appConfig.showPrototypeTimeControls,
          allowCompanionNameEditing:
              _companionEvents.isEventHandled(
                CompanionEventDefinitions.companionNameId,
              ) ||
              _companionEvents.isEventAutoTriggered(
                CompanionEventDefinitions.companionNameId,
              ),
          allowUserNameEditing:
              _companionEvents.isEventHandled(
                CompanionEventDefinitions.userNameId,
              ) ||
              _companionEvents.isEventAutoTriggered(
                CompanionEventDefinitions.userNameId,
              ),
          initialSleepSound: _sleepSound,
          allowBackgroundMusicEditing:
              _companionEvents.isEventHandled(
                CompanionEventDefinitions.backgroundMusicId,
              ) ||
              _companionEvents.isEventAutoTriggered(
                CompanionEventDefinitions.backgroundMusicId,
              ),
          initialBackgroundMusic: _backgroundMusic,
          onPreviewBackgroundMusic: (option) {
            unawaited(_previewBackgroundMusic(option));
          },
          onStopPreviewBackgroundMusic: () {
            unawaited(_stopBackgroundMusicPreview());
          },
          allowSymbolEditing:
              _companionEvents.isEventHandled(
                CompanionEventDefinitions.symbolId,
              ) ||
              _companionEvents.isEventAutoTriggered(
                CompanionEventDefinitions.symbolId,
              ),
          allowBackgroundToneEditing:
              _companionEvents.isEventHandled(
                CompanionEventDefinitions.backgroundColorId,
              ) ||
              _companionEvents.isEventAutoTriggered(
                CompanionEventDefinitions.backgroundColorId,
              ),
          initialCompanionName: _companionName,
          initialUserName: _userName,
          initialSymbol: _companionSymbol,
          initialBackgroundTone: _backgroundTone,
          feedbackScreenshotCapture: widget.feedbackScreenshotCapture,
        ),
      ),
    );

    await _stopBackgroundMusicPreview();

    if (result == null) {
      return;
    }

    setState(() {
      _focusAreas = result.focusAreas;
      _selectedSettingsAreaId = _resolveSelectedAreaId(
        areas: _focusAreas,
        preferred: result.selectedAreaId,
      );
      _simulatedHour = result.simulatedHour;
      _companionName = result.companionName;
      _userName = result.userName;
      _sleepSound = result.sleepSound;
      _backgroundMusic = result.backgroundMusic;
      _companionSymbol = result.symbol;
      _backgroundTone = result.backgroundTone;
      _persistCompanionIdentityState();
      _persistFocusAreaSettingsState();
    });

    _scheduleAutomaticPromptEvaluation(forceStatusRefresh: true);
  }

  Future<void> _openHistory() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => HistoryScreen(
          historyRepository: widget.historyRepository,
          feedbackRepository: widget.feedbackRepository,
          feedbackScreenshotCapture: widget.feedbackScreenshotCapture,
        ),
      ),
    );
  }

  String _moodLabel(Sinnsstemning mood) {
    switch (mood) {
      case Sinnsstemning.negativ:
        return 'Tung';
      case Sinnsstemning.ok:
        return 'Ok';
      case Sinnsstemning.energisk:
        return 'Energisk';
    }
  }

  String _pickFrom(List<String> values) {
    return values[_random.nextInt(values.length)];
  }

  @override
  Widget build(BuildContext context) {
    _scheduleBackgroundMusicSync();

    return Scaffold(
      appBar: AppBar(
        leading: _isSleepFeatureUnlocked()
            ? IconButton(
                key: const ValueKey('sleep-feature-icon-button'),
                onPressed: _openSleepFeatureSheet,
                icon: const Icon(Icons.nightlight_round),
                tooltip: 'Søvnfunksjon',
              )
            : null,
        centerTitle: true,
        title: Text(_headerTitle()),
        actions: [
          IconButton(
            onPressed: _openHistory,
            icon: const Icon(Icons.bar_chart_outlined),
            tooltip: 'Historikk',
          ),
          FeedbackActionButton(
            feedbackRepository: widget.feedbackRepository,
            captureKey: _feedbackCaptureKey,
            captureScreenshot: widget.feedbackScreenshotCapture,
            screenContext: 'home',
          ),
          IconButton(
            onPressed: _openSettings,
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Innstillinger',
          ),
        ],
      ),
      backgroundColor: _backgroundTone.scaffoldColor,
      body: RepaintBoundary(
        key: _feedbackCaptureKey,
        child: HomeLayoutShell(
          dialogue: DialogueBox(text: _dialogueLines().join(' ')),
          figure: _stage == PromptStage.result
              ? GestureDetector(
                  onTap: _resetToIdle,
                  behavior: HitTestBehavior.translucent,
                  child: CompanionFigure(
                    animationState: _companionAnimationState,
                  ),
                )
              : CompanionFigure(animationState: _companionAnimationState),
          bottomActions: BottomActionArea(child: _buildBottomActionState()),
        ),
      ),
    );
  }

  List<String> _dialogueLines() {
    if (_stage == PromptStage.idle) {
      return [
        if (_statusMessage != null)
          _statusMessage!
        else
          _userName == null
              ? 'Hei. Hvordan er formen din akkurat nå?'
              : 'Hei, $_userName. Hvordan er formen din akkurat nå?',
      ];
    }

    if (_stage == PromptStage.mood) {
      return ['Hei. Hvordan kjennes det akkurat nå?'];
    }

    if (_stage == PromptStage.task) {
      final task = _currentTask;
      if (task == null) {
        return [
          'Jeg finner ingen oppgave akkurat nå. Vi kan prøve igjen snart.',
        ];
      }

      return [task.title];
    }

    if (_stage == PromptStage.companionNameEvent) {
      return ['Vil du gi meg et navn?'];
    }

    if (_stage == PromptStage.userNameEvent) {
      return ['Hva heter du?'];
    }

    if (_stage == PromptStage.sleepSoundEvent) {
      return ['Du har fått en ny funksjon'];
    }

    if (_stage == PromptStage.backgroundMusicEvent) {
      return ['Du har fått en ny funksjon'];
    }

    if (_stage == PromptStage.symbolEvent) {
      return ['Vil du velge et lite symbol som kan være en del av meg?'];
    }

    if (_stage == PromptStage.backgroundColorEvent) {
      return ['Hvilken farge føles best for deg i appen?'];
    }

    return [_resultMessage ?? 'Helt greit.'];
  }

  Widget _buildBottomActionState() {
    final Widget child;

    if (_stage == PromptStage.idle) {
      if (!widget.appConfig.showPrototypeControls) {
        child = const SizedBox.shrink();
      } else {
        child = IdleStateView(
          onSimulate: _simulateNextPrompt,
          actionLabel: 'Simuler neste prompt',
        );
      }
    } else if (_stage == PromptStage.mood) {
      child = MoodStateView(
        onSelectMood: _selectMood,
        labelBuilder: _moodLabel,
      );
    } else if (_stage == PromptStage.task) {
      child = TaskStateView(
        hasTask: _currentTask != null,
        onDone: () => _submitResult(true),
        onSkipped: () => _submitResult(false),
        onBack: _resetToIdle,
      );
    } else if (_stage == PromptStage.companionNameEvent) {
      child = CompanionNameEventView(
        onSave: _saveCompanionName,
        onSkip: _skipCompanionNameEvent,
      );
    } else if (_stage == PromptStage.userNameEvent) {
      child = UserNameEventView(
        onSave: _saveUserName,
        onSkip: _skipUserNameEvent,
      );
    } else if (_stage == PromptStage.sleepSoundEvent) {
      child = SleepSoundEventView(
        onCheckNow: () {
          unawaited(_openSleepFeatureFromEvent());
        },
        onLater: _checkSleepFeatureLater,
      );
    } else if (_stage == PromptStage.backgroundMusicEvent) {
      child = BackgroundMusicEventView(
        onCheckNow: () {
          unawaited(_openBackgroundMusicSettingsFromEvent());
        },
        onLater: _checkBackgroundMusicLater,
      );
    } else if (_stage == PromptStage.symbolEvent) {
      child = SymbolEventView(onSave: _saveSymbol, onSkip: _skipSymbolEvent);
    } else if (_stage == PromptStage.backgroundColorEvent) {
      child = BackgroundColorEventView(
        onSave: _saveBackgroundTone,
        onSkip: _skipBackgroundColorEvent,
      );
    } else {
      child = ResultStateView(onBack: _resetToIdle);
    }

    return _wrapBottomActionWithSleepPlayer(child);
  }
}
