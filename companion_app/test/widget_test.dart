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
    expect(find.text('Velg et Fokusomrade'), findsOneWidget);
    expect(find.text('Huslige oppgaver'), findsWidgets);
  });
}
