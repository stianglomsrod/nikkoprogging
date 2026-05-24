import 'package:flutter_test/flutter_test.dart';

import 'package:companion_app/app/companion_app.dart';

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
}
