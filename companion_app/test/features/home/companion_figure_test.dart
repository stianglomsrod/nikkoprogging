import 'package:companion_app/features/home/widgets/companion_figure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpFigure(
    WidgetTester tester,
    CompanionAnimationState state,
  ) {
    return tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CompanionFigure(animationState: state)),
      ),
    );
  }

  String currentAsset(WidgetTester tester) {
    final image = tester.widget<Image>(
      find.descendant(
        of: find.byType(CompanionFigure),
        matching: find.byType(Image),
      ),
    );
    return (image.image as AssetImage).assetName;
  }

  testWidgets('sleep-tilstand bruker de nye sove-framene', (
    WidgetTester tester,
  ) async {
    await pumpFigure(tester, CompanionAnimationState.sleep);

    final seenAssets = <String>{};
    for (var i = 0; i < 12; i++) {
      seenAssets.add(currentAsset(tester));
      await tester.pump(const Duration(milliseconds: 420));
    }

    expect(
      seenAssets,
      containsAll(<String>{
        'assets/figures/companion/E1 - Sleep.png',
        'assets/figures/companion/E2 - Sleep.png',
        'assets/figures/companion/E3 - Sleep.png',
      }),
    );
    expect(
      seenAssets.every((asset) => asset.contains('Sleep')),
      isTrue,
      reason: 'sleep-tilstand skal kun bruke sove-frames',
    );
  });

  testWidgets('idle-tilstand bruker fortsatt puste/blunke-frames', (
    WidgetTester tester,
  ) async {
    await pumpFigure(tester, CompanionAnimationState.idle);

    final seenAssets = <String>{};
    for (var i = 0; i < 14; i++) {
      seenAssets.add(currentAsset(tester));
      await tester.pump(const Duration(milliseconds: 420));
    }

    expect(
      seenAssets.any((asset) => asset.contains('Breath')),
      isTrue,
      reason: 'idle skal bruke puste-frames',
    );
    expect(
      seenAssets.any((asset) => asset.contains('Sleep')),
      isFalse,
      reason: 'idle skal ikke bruke sove-frames',
    );
  });
}
