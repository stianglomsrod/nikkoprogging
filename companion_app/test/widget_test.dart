import 'package:flutter_test/flutter_test.dart';

import 'package:companion_app/app/companion_app.dart';
import 'package:companion_app/features/home/widgets/dialogue_box.dart';

void main() {
  testWidgets('viser prototype-startskjerm', (WidgetTester tester) async {
    await tester.pumpWidget(const CompanionApp());

    expect(find.text('.....'), findsOneWidget);
    expect(find.text('Simuler neste prompt'), findsOneWidget);
    expect(find.byTooltip('Innstillinger'), findsOneWidget);
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

    expect(find.text('Tung'), findsOneWidget);
    expect(find.text('Ok'), findsOneWidget);
    expect(find.text('Energisk'), findsOneWidget);

    await tester.tap(find.text('Ok'));
    await tester.pumpAndSettle();

    expect(find.text('Fikk du gjort oppgaven?'), findsOneWidget);
    expect(find.text('Ja'), findsOneWidget);
    expect(find.text('Nei'), findsOneWidget);
    expect(find.text('Hva passer best for deg akkurat nå?'), findsNothing);

    await tester.tap(find.text('Ja'));
    await tester.pumpAndSettle();

    expect(find.text('Tilbake'), findsOneWidget);
  });

  testWidgets('forste energisk utloser ikke kjede alene', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CompanionApp());

    await _startPromptAndPickMood(tester, 'Energisk');

    expect(find.text('Fikk du gjort oppgaven?'), findsOneWidget);
    await tester.tap(find.text('Ja'));
    await tester.pumpAndSettle();

    expect(find.text('Tilbake'), findsOneWidget);
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

    expect(find.text('Tilbake'), findsOneWidget);
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
    await tester.tap(find.text('Tilbake'));
    await tester.pumpAndSettle();

    await _startPromptAndPickMood(tester, 'Energisk');
    await tester.tap(find.text('Ja'));
    await tester.pumpAndSettle();

    expect(find.text('Tilbake'), findsOneWidget);
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

    expect(find.text('Tilbake'), findsOneWidget);
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
  await tester.tap(find.text('Tilbake'));
  await tester.pumpAndSettle();
}

String _currentDialogueText(WidgetTester tester) {
  final dialogue = tester.widget<DialogueBox>(find.byType(DialogueBox));
  return dialogue.text;
}
