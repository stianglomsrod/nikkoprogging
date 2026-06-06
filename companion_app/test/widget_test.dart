import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:companion_app/app/companion_app.dart';
import 'package:companion_app/features/home/widgets/companion_figure.dart';
import 'package:companion_app/features/home/widgets/dialogue_box.dart';

void main() {
  testWidgets('viser prototype-startskjerm', (WidgetTester tester) async {
    await tester.pumpWidget(const CompanionApp());

    expect(find.text('.....'), findsOneWidget);
    expect(find.text('Simuler neste prompt'), findsOneWidget);
    expect(find.byTooltip('Innstillinger'), findsOneWidget);
  });

  testWidgets('companion figur rendres med idle-animasjonsframes', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CompanionApp());

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
    await tester.pumpWidget(const CompanionApp());

    await tester.tap(find.byTooltip('Innstillinger'));
    await tester.pumpAndSettle();

    expect(find.text('Innstillinger'), findsOneWidget);
    expect(find.text('Velg et Fokusområde'), findsOneWidget);
    expect(find.text('Huslige oppgaver'), findsWidgets);
  });

  testWidgets('flyt gar fra stemning til oppgave og resultat', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CompanionApp());

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

  testWidgets('stemningsknapper vises i rekkefolge Energisk, Ok, Tung', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CompanionApp());

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
      await tester.pumpWidget(const CompanionApp());

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
    await tester.pumpWidget(const CompanionApp());

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
    await tester.pumpWidget(const CompanionApp());

    await _startPromptAndPickMood(tester, 'Energisk');

    expect(find.text('Fikk du gjort oppgaven?'), findsOneWidget);
    await tester.tap(find.text('Ja'));
    await tester.pumpAndSettle();

    expect(find.text('Fortsett'), findsOneWidget);
  });

  testWidgets('andre energisk pa rad utloser tokjedeutgave uten ny mood', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CompanionApp());

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
    await tester.pumpWidget(const CompanionApp());

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
    await tester.pumpWidget(const CompanionApp());

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
    await tester.pumpWidget(const CompanionApp());

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
    await tester.pumpWidget(const CompanionApp());

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
    await tester.pumpWidget(const CompanionApp());

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
  await tester.tap(find.text('Simuler neste prompt'));
  await tester.pumpAndSettle();

  await tester.tap(find.text(moodLabel));
  await tester.pumpAndSettle();
}

Future<void> _runSinglePromptAndFinish(
  WidgetTester tester, {
  required String moodLabel,
  required bool done,
}) async {
  await _startPromptAndPickMood(tester, moodLabel);
  await tester.tap(find.text(done ? 'Ja' : 'Nei'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Fortsett'));
  await tester.pumpAndSettle();
}

String _currentDialogueText(WidgetTester tester) {
  final dialogue = tester.widget<DialogueBox>(find.byType(DialogueBox));
  return dialogue.text;
}

CompanionAnimationState _currentCompanionAnimationState(WidgetTester tester) {
  return tester.widget<CompanionFigure>(find.byType(CompanionFigure)).animationState;
}
