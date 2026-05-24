import 'package:flutter_test/flutter_test.dart';

import 'package:companion_app/app/companion_app.dart';

void main() {
  testWidgets('viser prototype-startskjerm', (WidgetTester tester) async {
    await tester.pumpWidget(const CompanionApp());

    expect(find.text('Rolig Companion Prototype'), findsOneWidget);
    expect(find.text('Status'), findsOneWidget);
    expect(find.text('Fokusomrader'), findsOneWidget);
  });
}
