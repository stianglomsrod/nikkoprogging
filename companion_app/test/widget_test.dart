import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:companion_app/app/companion_app.dart';
import 'package:companion_app/core/events/companion_event_state_repository.dart';
import 'package:companion_app/core/events/companion_event_state_snapshot.dart';
import 'package:companion_app/core/events/companion_identity_repository.dart';
import 'package:companion_app/core/events/companion_identity_state_snapshot.dart';
import 'package:companion_app/core/feedback/feedback_item.dart';
import 'package:companion_app/core/feedback/feedback_repository.dart';
import 'package:companion_app/core/history/in_memory_history_repository.dart';
import 'package:companion_app/core/events/companion_identity.dart';
import 'package:companion_app/core/settings/focus_area_settings_repository.dart';
import 'package:companion_app/core/settings/focus_area_settings_state_snapshot.dart';
import 'package:companion_app/features/home/widgets/companion_figure.dart';
import 'package:companion_app/features/home/widgets/dialogue_box.dart';

class _InMemoryCompanionEventStateRepository
    implements CompanionEventStateRepository {
  CompanionEventStateSnapshot? _snapshot;

  @override
  Future<CompanionEventStateSnapshot?> readState() async {
    return _snapshot;
  }

  @override
  Future<void> writeState(CompanionEventStateSnapshot snapshot) async {
    _snapshot = snapshot;
  }
}

class _InMemoryCompanionIdentityRepository
    implements CompanionIdentityRepository {
  CompanionIdentityStateSnapshot? _snapshot;

  @override
  Future<CompanionIdentityStateSnapshot?> readState() async {
    return _snapshot;
  }

  @override
  Future<void> writeState(CompanionIdentityStateSnapshot snapshot) async {
    _snapshot = snapshot;
  }
}

class _InMemoryFocusAreaSettingsRepository
    implements FocusAreaSettingsRepository {
  FocusAreaSettingsStateSnapshot? _snapshot;

  @override
  Future<FocusAreaSettingsStateSnapshot?> readState() async {
    return _snapshot;
  }

  @override
  Future<void> writeState(FocusAreaSettingsStateSnapshot snapshot) async {
    _snapshot = snapshot;
  }
}

class _InMemoryFeedbackRepository implements FeedbackRepository {
  final List<FeedbackItem> items = <FeedbackItem>[];

  @override
  Future<void> append(FeedbackItem item) async {
    items.removeWhere((existing) => existing.id == item.id);
    items.add(item);
  }

  @override
  Future<List<FeedbackItem>> readAll() async {
    final copied = List<FeedbackItem>.from(items);
    copied.sort((a, b) => b.createdAtMs.compareTo(a.createdAtMs));
    return copied;
  }

  @override
  Future<FeedbackItem?> readById(String id) async {
    for (final item in items) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }
}

CompanionApp _buildApp({FeedbackRepository? feedbackRepository}) {
  return CompanionApp(
    historyRepository: InMemoryHistoryRepository(),
    feedbackRepository: feedbackRepository ?? _InMemoryFeedbackRepository(),
    companionEventStateRepository: _InMemoryCompanionEventStateRepository(),
    companionIdentityRepository: _InMemoryCompanionIdentityRepository(),
    focusAreaSettingsRepository: _InMemoryFocusAreaSettingsRepository(),
  );
}

void main() {
  testWidgets('viser prototype-startskjerm', (WidgetTester tester) async {
    await tester.pumpWidget(_buildApp());

    expect(find.text('.....'), findsOneWidget);
    expect(find.text('Simuler neste prompt'), findsOneWidget);
    expect(find.byTooltip('Tilbakemelding'), findsOneWidget);
    expect(find.byTooltip('Innstillinger'), findsOneWidget);
  });

  testWidgets('feedbackmodal validerer tom melding', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildApp());

    await tester.tap(find.byTooltip('Tilbakemelding'));
    await tester.pumpAndSettle();

    expect(find.text('Del tilbakemelding'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('feedback-send-button')));
    await tester.pumpAndSettle();

    expect(find.text('Skriv litt om hva du vil dele.'), findsOneWidget);
    expect(find.text('Del tilbakemelding'), findsOneWidget);
  });

  testWidgets('feedbackmodal sender og lagrer tilbakemelding', (
    WidgetTester tester,
  ) async {
    final feedbackRepository = _InMemoryFeedbackRepository();
    await tester.pumpWidget(_buildApp(feedbackRepository: feedbackRepository));

    await tester.tap(find.byTooltip('Tilbakemelding'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Feil'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('feedback-message-input')),
      'Appen hopper litt nar jeg gar tilbake.',
    );

    await tester.tap(find.byKey(const ValueKey('feedback-send-button')));
    await tester.pumpAndSettle();

    expect(find.text('Del tilbakemelding'), findsNothing);
    expect(find.text('Takk. Tilbakemeldingen er lagret.'), findsOneWidget);
    expect(feedbackRepository.items, hasLength(1));
    expect(feedbackRepository.items.first.type, FeedbackType.bug);
    expect(
      feedbackRepository.items.first.message,
      'Appen hopper litt nar jeg gar tilbake.',
    );
    expect(feedbackRepository.items.first.screenContext, 'home');
  });

  testWidgets('feedbackhistorikk viser lagrede innspill og detalj', (
    WidgetTester tester,
  ) async {
    final feedbackRepository = _InMemoryFeedbackRepository();
    await feedbackRepository.append(
      const FeedbackItem(
        id: 'fb_a',
        createdAtMs: 100,
        type: FeedbackType.general,
        message: 'Rolig flyt i appen.',
        screenContext: 'home',
      ),
    );
    await feedbackRepository.append(
      const FeedbackItem(
        id: 'fb_b',
        createdAtMs: 200,
        type: FeedbackType.suggestion,
        message: 'Kunne hatt litt tydeligere overskrifter.',
        screenContext: 'home',
      ),
    );

    await tester.pumpWidget(_buildApp(feedbackRepository: feedbackRepository));

    await tester.tap(find.byTooltip('Tilbakemelding'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Historikk'));
    await tester.pumpAndSettle();

    expect(find.text('Tilbakemeldinger'), findsOneWidget);
    expect(find.text('Forslag'), findsOneWidget);
    expect(find.text('Generell'), findsOneWidget);
    expect(
      find.text('Kunne hatt litt tydeligere overskrifter.'),
      findsOneWidget,
    );

    await tester.tap(find.byKey(const ValueKey('feedback-history-item-fb_b')));
    await tester.pumpAndSettle();

    expect(find.text('Tilbakemelding'), findsOneWidget);
    expect(find.text('Melding'), findsOneWidget);
    expect(
      find.text('Kunne hatt litt tydeligere overskrifter.'),
      findsOneWidget,
    );
    expect(find.text('Skjerm'), findsOneWidget);
    expect(find.text('Hjem'), findsOneWidget);
  });

  testWidgets('companion figur rendres med idle-animasjonsframes', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildApp());

    final image = tester.widget<Image>(
      find.descendant(
        of: find.byType(CompanionFigure),
        matching: find.byType(Image),
      ),
    );

    final provider = image.image;
    expect(provider, isA<AssetImage>());
    expect(
      (provider as AssetImage).assetName,
      startsWith('assets/animations/companion/idle/frame_'),
    );
    expect(
      _currentCompanionAnimationState(tester),
      CompanionAnimationState.idle,
    );
  });

  testWidgets('apner roligere innstillinger med fokusomradevalg', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildApp());

    await tester.tap(find.byTooltip('Innstillinger'));
    await tester.pumpAndSettle();

    expect(find.text('Innstillinger'), findsOneWidget);
    expect(find.text('Velg et Fokusområde'), findsOneWidget);
    expect(find.text('Huslige oppgaver'), findsWidgets);
    expect(find.text('Modus'), findsOneWidget);
    expect(find.text('Aktivt tidsrom'), findsOneWidget);
    expect(find.text('Companion-navn'), findsNothing);
    expect(find.text('Ditt navn'), findsNothing);
    expect(find.text('Symbol'), findsNothing);
    expect(find.text('Bakgrunnsfarge'), findsNothing);

    await tester.tap(find.byKey(const ValueKey('focus-area-circle-study')));
    await tester.pumpAndSettle();

    expect(find.text('Studier og læring'), findsWidgets);
    expect(find.byType(ChoiceChip), findsNWidgets(3));
    expect(find.byType(RangeSlider), findsOneWidget);
  });

  testWidgets('flyt gar fra stemning til oppgave og resultat', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildApp());

    await tester.tap(find.text('Simuler neste prompt'));
    await tester.pumpAndSettle();

    expect(find.text('Energisk'), findsOneWidget);
    expect(find.text('Ok'), findsOneWidget);
    expect(find.text('Tung'), findsOneWidget);

    await tester.tap(find.text('Ok'));
    await tester.pumpAndSettle();

    expect(find.text('Fikk du gjort oppgaven?'), findsOneWidget);
    expect(find.text('Ja'), findsOneWidget);
    expect(find.text('Nei'), findsOneWidget);
    expect(find.text('Hva passer best for deg akkurat nå?'), findsNothing);

    await tester.tap(find.text('Ja'));
    await tester.pumpAndSettle();

    expect(find.text('Fortsett'), findsOneWidget);
  });

  testWidgets(
    'companion-navneevent vises etter tre fullforte og skip beholder .....',
    (WidgetTester tester) async {
      await tester.pumpWidget(_buildApp());

      await _runSinglePromptAndFinish(tester, moodLabel: 'Ok', done: true);
      await _runSinglePromptAndFinish(tester, moodLabel: 'Ok', done: true);

      await _startPromptAndPickMood(tester, 'Ok');
      await tester.tap(find.text('Ja'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Fortsett'));
      await tester.pumpAndSettle();

      expect(find.text('Vil du gi meg et navn?'), findsOneWidget);
      expect(
        find.byKey(const ValueKey('companion-name-input')),
        findsOneWidget,
      );

      await tester.tap(
        find.byKey(const ValueKey('companion-name-skip-button')),
      );
      await tester.pumpAndSettle();

      expect(find.text('.....'), findsOneWidget);
      expect(find.text('Simuler neste prompt'), findsOneWidget);
    },
  );

  testWidgets(
    'lagret companion-navn erstatter ..... og event trigges ikke pa nytt',
    (WidgetTester tester) async {
      await tester.pumpWidget(_buildApp());

      await _runSinglePromptAndFinish(tester, moodLabel: 'Ok', done: true);
      await _runSinglePromptAndFinish(tester, moodLabel: 'Ok', done: true);

      await _startPromptAndPickMood(tester, 'Ok');
      await tester.tap(find.text('Ja'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Fortsett'));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(const ValueKey('companion-name-input')),
        'Milo',
      );
      await tester.pumpAndSettle();
      await tester.tap(
        find.byKey(const ValueKey('companion-name-save-button')),
      );
      await tester.pumpAndSettle();

      expect(find.text('Milo'), findsOneWidget);

      await _runSinglePromptAndFinish(tester, moodLabel: 'Ok', done: true);
      await _runSinglePromptAndFinish(tester, moodLabel: 'Ok', done: true);
      await _runSinglePromptAndFinish(tester, moodLabel: 'Ok', done: true);

      expect(find.text('Vil du gi meg et navn?'), findsNothing);
      expect(find.text('Milo'), findsOneWidget);
    },
  );

  testWidgets('etter skip kan companion-navn settes i innstillinger', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildApp());

    await _runSinglePromptAndFinish(tester, moodLabel: 'Ok', done: true);
    await _runSinglePromptAndFinish(tester, moodLabel: 'Ok', done: true);

    await _startPromptAndPickMood(tester, 'Ok');
    await tester.tap(find.text('Ja'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Fortsett'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('companion-name-skip-button')));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Innstillinger'));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.byKey(const ValueKey('settings-companion-name-input')),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();

    expect(find.text('Companion-navn'), findsOneWidget);
    await tester.enterText(
      find.byKey(const ValueKey('settings-companion-name-input')),
      'Nova',
    );

    await tester.tap(find.text('Lagre'));
    await tester.pumpAndSettle();

    expect(find.text('Nova'), findsOneWidget);
  });

  testWidgets('user-navneevent vises etter seks fullforte og skip er mulig', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildApp());

    await _runSinglePromptAndFinish(
      tester,
      moodLabel: 'Ok',
      done: true,
      autoHandleCompanionNameEvent: true,
      autoHandleUserNameEvent: false,
    );
    await _runSinglePromptAndFinish(
      tester,
      moodLabel: 'Ok',
      done: true,
      autoHandleCompanionNameEvent: true,
      autoHandleUserNameEvent: false,
    );
    await _runSinglePromptAndFinish(
      tester,
      moodLabel: 'Ok',
      done: true,
      autoHandleCompanionNameEvent: true,
      autoHandleUserNameEvent: false,
    );
    await _runSinglePromptAndFinish(
      tester,
      moodLabel: 'Ok',
      done: true,
      autoHandleCompanionNameEvent: true,
      autoHandleUserNameEvent: false,
    );
    await _runSinglePromptAndFinish(
      tester,
      moodLabel: 'Ok',
      done: true,
      autoHandleCompanionNameEvent: true,
      autoHandleUserNameEvent: false,
    );

    await _startPromptAndPickMood(tester, 'Ok');
    await tester.tap(find.text('Ja'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Fortsett'));
    await tester.pumpAndSettle();

    expect(find.text('Hva heter du?'), findsOneWidget);
    expect(find.byKey(const ValueKey('user-name-input')), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('user-name-skip-button')));
    await tester.pumpAndSettle();

    expect(find.text('Simuler neste prompt'), findsOneWidget);
  });

  testWidgets('lagret brukernavn kan brukes i rolig hilsen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildApp());

    for (int i = 0; i < 5; i++) {
      await _runSinglePromptAndFinish(
        tester,
        moodLabel: 'Ok',
        done: true,
        autoHandleCompanionNameEvent: true,
        autoHandleUserNameEvent: false,
      );
    }

    await _startPromptAndPickMood(tester, 'Ok');
    await tester.tap(find.text('Ja'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Fortsett'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const ValueKey('user-name-input')),
      'Ada',
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('user-name-save-button')));
    await tester.pumpAndSettle();

    final idleDialogue = _currentDialogueText(tester).toLowerCase();
    expect(idleDialogue, contains('ada'));
  });

  testWidgets('etter user-navneevent kan navn endres i innstillinger', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildApp());

    for (int i = 0; i < 5; i++) {
      await _runSinglePromptAndFinish(
        tester,
        moodLabel: 'Ok',
        done: true,
        autoHandleCompanionNameEvent: true,
        autoHandleUserNameEvent: false,
      );
    }

    await _startPromptAndPickMood(tester, 'Ok');
    await tester.tap(find.text('Ja'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Fortsett'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('user-name-skip-button')));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Innstillinger'));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.byKey(const ValueKey('settings-user-name-input')),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();

    expect(find.text('Ditt navn'), findsOneWidget);
    await tester.enterText(
      find.byKey(const ValueKey('settings-user-name-input')),
      'Luna',
    );

    await tester.tap(find.text('Lagre'));
    await tester.pumpAndSettle();

    final idleDialogue = _currentDialogueText(tester).toLowerCase();
    expect(idleDialogue, contains('luna'));
  });

  testWidgets('symbolevent vises etter femten fullforte og kan lagres', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildApp());

    await _setAllFocusAreasToSporty(tester);

    for (int i = 0; i < 10; i++) {
      await _runSinglePromptAndFinish(
        tester,
        moodLabel: 'Energisk',
        done: true,
        autoHandleCompanionNameEvent: true,
        autoHandleUserNameEvent: true,
        autoHandleSymbolEvent: false,
      );
    }

    expect(
      find.text('Vil du velge et lite symbol som kan være en del av meg?'),
      findsOneWidget,
    );

    await tester.tap(find.byKey(const ValueKey('symbol-option-star')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('symbol-save-button')));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Innstillinger'));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.byKey(const ValueKey('settings-symbol-option-star')),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();

    final starChip = tester.widget<ChoiceChip>(
      find.byKey(const ValueKey('settings-symbol-option-star')),
    );
    expect(starChip.selected, isTrue);
  });

  testWidgets('bakgrunnsfargeevent vises etter atten fullforte og kan lagres', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildApp());

    await _setAllFocusAreasToSporty(tester);

    for (int i = 0; i < 12; i++) {
      await _runSinglePromptAndFinish(
        tester,
        moodLabel: 'Energisk',
        done: true,
        autoHandleCompanionNameEvent: true,
        autoHandleUserNameEvent: true,
        autoHandleSymbolEvent: true,
        autoHandleBackgroundColorEvent: false,
      );
    }

    expect(
      find.text('Hvilken farge føles best for deg i appen?'),
      findsOneWidget,
    );

    await tester.tap(find.byKey(const ValueKey('background-option-deepGreen')));
    await tester.pumpAndSettle();
    await tester.tap(
      find.byKey(const ValueKey('background-color-save-button')),
    );
    await tester.pumpAndSettle();

    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold).first);
    expect(
      scaffold.backgroundColor,
      CompanionBackgroundTone.deepGreen.scaffoldColor,
    );
  });

  testWidgets(
    'bakgrunnsfargeevent kan hoppes over og beholder standard mørk tone',
    (WidgetTester tester) async {
      await tester.pumpWidget(_buildApp());

      await _setAllFocusAreasToSporty(tester);

      for (int i = 0; i < 12; i++) {
        await _runSinglePromptAndFinish(
          tester,
          moodLabel: 'Energisk',
          done: true,
          autoHandleCompanionNameEvent: true,
          autoHandleUserNameEvent: true,
          autoHandleSymbolEvent: true,
          autoHandleBackgroundColorEvent: false,
        );
      }

      expect(
        find.text('Hvilken farge føles best for deg i appen?'),
        findsOneWidget,
      );

      await tester.tap(
        find.byKey(const ValueKey('background-color-skip-button')),
      );
      await tester.pumpAndSettle();

      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold).first);
      expect(
        scaffold.backgroundColor,
        CompanionBackgroundTone.defaultDark.scaffoldColor,
      );
    },
  );

  testWidgets('stemningsknapper vises i rekkefolge Energisk, Ok, Tung', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildApp());

    await tester.tap(find.text('Simuler neste prompt'));
    await tester.pumpAndSettle();

    final moodButtons = tester.widgetList<FilledButton>(
      find.descendant(
        of: find.byKey(const ValueKey('actions-mood')),
        matching: find.byType(FilledButton),
      ),
    );

    final labels = moodButtons
        .map((button) {
          final child = button.child;
          if (child is Text) {
            return child.data;
          }
          return null;
        })
        .whereType<String>()
        .toList(growable: false);

    expect(labels, ['Energisk', 'Ok', 'Tung']);
  });

  testWidgets(
    'idle viser vennlig ingen-oppgaver-kopi nar kvoter er brukt opp',
    (WidgetTester tester) async {
      await tester.pumpWidget(_buildApp());

      for (int i = 0; i < 7; i++) {
        await _runSinglePromptAndFinish(tester, moodLabel: 'Ok', done: true);
      }

      await tester.tap(find.text('Simuler neste prompt'));
      await tester.pumpAndSettle();

      final dialogue = _currentDialogueText(tester).toLowerCase();
      expect(dialogue, contains('fint å se deg'));
      expect(dialogue, contains('ingen oppgaver til deg akkurat nå'));
      expect(
        _currentCompanionAnimationState(tester),
        CompanionAnimationState.sleep,
      );
    },
  );

  testWidgets('ja viser happy kortvarig og gar tilbake til idle', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildApp());

    await _startPromptAndPickMood(tester, 'Ok');
    await tester.tap(find.text('Ja'));
    await tester.pumpAndSettle();

    expect(find.text('Fortsett'), findsOneWidget);
    expect(
      _currentCompanionAnimationState(tester),
      CompanionAnimationState.happy,
    );

    await tester.pump(const Duration(milliseconds: 2400));

    expect(
      _currentCompanionAnimationState(tester),
      CompanionAnimationState.idle,
    );
  });

  testWidgets('forste energisk utloser ikke kjede alene', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildApp());

    await _startPromptAndPickMood(tester, 'Energisk');

    expect(find.text('Fikk du gjort oppgaven?'), findsOneWidget);
    await tester.tap(find.text('Ja'));
    await tester.pumpAndSettle();

    expect(find.text('Fortsett'), findsOneWidget);
  });

  testWidgets('andre energisk pa rad utloser tokjedeutgave uten ny mood', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildApp());

    await _runSinglePromptAndFinish(tester, moodLabel: 'Energisk', done: true);

    await _startPromptAndPickMood(tester, 'Energisk');
    expect(find.text('Fikk du gjort oppgaven?'), findsOneWidget);

    await tester.tap(find.text('Nei'));
    await tester.pumpAndSettle();

    expect(find.text('Fikk du gjort oppgaven?'), findsOneWidget);
    expect(find.text('Tung'), findsNothing);
    expect(find.text('Ok'), findsNothing);
    expect(find.text('Energisk'), findsNothing);

    await tester.tap(find.text('Ja'));
    await tester.pumpAndSettle();

    expect(find.text('Fortsett'), findsOneWidget);
  });

  testWidgets('etter andre kjedeutgave resettes kjeden', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildApp());

    await _runSinglePromptAndFinish(tester, moodLabel: 'Energisk', done: true);

    await _startPromptAndPickMood(tester, 'Energisk');
    await tester.tap(find.text('Ja'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ja'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Fortsett'));
    await tester.pumpAndSettle();

    await _startPromptAndPickMood(tester, 'Energisk');
    await tester.tap(find.text('Ja'));
    await tester.pumpAndSettle();

    expect(find.text('Fortsett'), findsOneWidget);
  });

  testWidgets('ikke-energisk bryter energisk-sekvensen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildApp());

    await _runSinglePromptAndFinish(tester, moodLabel: 'Energisk', done: true);
    await _runSinglePromptAndFinish(tester, moodLabel: 'Ok', done: true);

    await _startPromptAndPickMood(tester, 'Energisk');
    await tester.tap(find.text('Nei'));
    await tester.pumpAndSettle();

    expect(find.text('Fortsett'), findsOneWidget);
  });

  testWidgets('andre kjedeutgave unngar a repetere forste oppgave nar mulig', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildApp());

    await _runSinglePromptAndFinish(tester, moodLabel: 'Energisk', done: true);

    await _startPromptAndPickMood(tester, 'Energisk');
    final firstTaskText = _currentDialogueText(tester);

    await tester.tap(find.text('Ja'));
    await tester.pumpAndSettle();

    final secondTaskText = _currentDialogueText(tester);
    expect(secondTaskText, isNot(equals(firstTaskText)));
  });

  testWidgets('tapping figur i resultattilstand fortsetter til idle', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildApp());

    await _startPromptAndPickMood(tester, 'Ok');
    await tester.tap(find.text('Ja'));
    await tester.pumpAndSettle();

    expect(find.text('Fortsett'), findsOneWidget);

    await tester.tap(find.byType(CompanionFigure));
    await tester.pumpAndSettle();

    expect(find.text('Simuler neste prompt'), findsOneWidget);
  });

  testWidgets('energisk-kjede fullforer og flyten forblir brukbar etterpa', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildApp());

    await _runSinglePromptAndFinish(tester, moodLabel: 'Energisk', done: true);

    await _startPromptAndPickMood(tester, 'Energisk');
    expect(find.text('Fikk du gjort oppgaven?'), findsOneWidget);

    await tester.tap(find.text('Nei'));
    await tester.pumpAndSettle();

    expect(find.text('Fikk du gjort oppgaven?'), findsOneWidget);
    expect(find.byKey(const ValueKey('actions-mood')), findsNothing);

    await tester.tap(find.text('Ja'));
    await tester.pumpAndSettle();

    expect(find.text('Fortsett'), findsOneWidget);
    await tester.tap(find.text('Fortsett'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Simuler neste prompt'));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('actions-mood')), findsOneWidget);
    expect(find.text('Energisk'), findsOneWidget);
  });
}

Future<void> _startPromptAndPickMood(
  WidgetTester tester,
  String moodLabel,
) async {
  await _dismissPendingIdentityEvents(tester);

  await tester.tap(find.text('Simuler neste prompt'));
  await tester.pumpAndSettle();

  await tester.tap(find.text(moodLabel));
  await tester.pumpAndSettle();
}

Future<void> _runSinglePromptAndFinish(
  WidgetTester tester, {
  required String moodLabel,
  required bool done,
  bool autoHandleCompanionNameEvent = true,
  bool autoHandleUserNameEvent = true,
  bool autoHandleSymbolEvent = true,
  bool autoHandleBackgroundColorEvent = true,
}) async {
  await _startPromptAndPickMood(tester, moodLabel);
  await tester.tap(find.text(done ? 'Ja' : 'Nei'));
  await tester.pumpAndSettle();

  if (find.text('Fortsett').evaluate().isEmpty &&
      find.text('Fikk du gjort oppgaven?').evaluate().isNotEmpty) {
    await tester.tap(find.text(done ? 'Ja' : 'Nei'));
    await tester.pumpAndSettle();
  }

  await tester.tap(find.text('Fortsett'));
  await tester.pumpAndSettle();

  if (autoHandleCompanionNameEvent &&
      find
          .byKey(const ValueKey('companion-name-skip-button'))
          .evaluate()
          .isNotEmpty) {
    await tester.tap(find.byKey(const ValueKey('companion-name-skip-button')));
    await tester.pumpAndSettle();
  }

  if (autoHandleUserNameEvent &&
      find
          .byKey(const ValueKey('user-name-skip-button'))
          .evaluate()
          .isNotEmpty) {
    await tester.tap(find.byKey(const ValueKey('user-name-skip-button')));
    await tester.pumpAndSettle();
  }

  if (autoHandleSymbolEvent &&
      find.byKey(const ValueKey('symbol-skip-button')).evaluate().isNotEmpty) {
    await tester.tap(find.byKey(const ValueKey('symbol-skip-button')));
    await tester.pumpAndSettle();
  }

  if (autoHandleBackgroundColorEvent &&
      find
          .byKey(const ValueKey('background-color-skip-button'))
          .evaluate()
          .isNotEmpty) {
    await tester.tap(
      find.byKey(const ValueKey('background-color-skip-button')),
    );
    await tester.pumpAndSettle();
  }
}

Future<void> _dismissPendingIdentityEvents(WidgetTester tester) async {
  if (find
      .byKey(const ValueKey('companion-name-skip-button'))
      .evaluate()
      .isNotEmpty) {
    await tester.tap(find.byKey(const ValueKey('companion-name-skip-button')));
    await tester.pumpAndSettle();
  }

  if (find
      .byKey(const ValueKey('user-name-skip-button'))
      .evaluate()
      .isNotEmpty) {
    await tester.tap(find.byKey(const ValueKey('user-name-skip-button')));
    await tester.pumpAndSettle();
  }

  if (find.byKey(const ValueKey('symbol-skip-button')).evaluate().isNotEmpty) {
    await tester.tap(find.byKey(const ValueKey('symbol-skip-button')));
    await tester.pumpAndSettle();
  }

  if (find
      .byKey(const ValueKey('background-color-skip-button'))
      .evaluate()
      .isNotEmpty) {
    await tester.tap(
      find.byKey(const ValueKey('background-color-skip-button')),
    );
    await tester.pumpAndSettle();
  }
}

Future<void> _setAllFocusAreasToSporty(WidgetTester tester) async {
  await tester.tap(find.byTooltip('Innstillinger'));
  await tester.pumpAndSettle();

  const focusAreaIds = <String>['household', 'study', 'exercise', 'reminders'];
  for (final areaId in focusAreaIds) {
    await tester.tap(find.byKey(ValueKey('focus-area-circle-$areaId')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('sporty'));
    await tester.pumpAndSettle();
  }

  await tester.tap(find.text('Lagre'));
  await tester.pumpAndSettle();
}

String _currentDialogueText(WidgetTester tester) {
  final dialogue = tester.widget<DialogueBox>(find.byType(DialogueBox));
  return dialogue.text;
}

CompanionAnimationState _currentCompanionAnimationState(WidgetTester tester) {
  return tester
      .widget<CompanionFigure>(find.byType(CompanionFigure))
      .animationState;
}
