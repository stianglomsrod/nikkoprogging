import 'dart:math';

import 'package:companion_app/core/models/focus_area.dart';
import 'package:companion_app/core/models/modus.dart';
import 'package:companion_app/core/scheduler/scheduler_engine.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SchedulerEngine', () {
    test(
      'enabled area is eligible inside active window when quota remains',
      () {
        final scheduler = SchedulerEngine(random: _FixedRandom(0));
        final area = _area(
          id: 'study',
          enabled: true,
          startHour: 10,
          endHour: 14,
          modus: Modus.stabil,
        );

        final selected = scheduler.selectEligibleFocusArea(
          focusAreas: [area],
          promptsUsed: const {'study': 1},
          currentHour: 11,
        );

        expect(selected?.id, 'study');
      },
    );

    test('area is not eligible outside active window', () {
      final scheduler = SchedulerEngine(random: _FixedRandom(0));
      final area = _area(
        id: 'study',
        enabled: true,
        startHour: 10,
        endHour: 14,
        modus: Modus.sporty,
      );

      final selected = scheduler.selectEligibleFocusArea(
        focusAreas: [area],
        promptsUsed: const {},
        currentHour: 20,
      );

      expect(selected, isNull);
    });

    test('disabled area is never eligible', () {
      final scheduler = SchedulerEngine(random: _FixedRandom(0));
      final area = _area(
        id: 'household',
        enabled: false,
        startHour: 0,
        endHour: 23,
        modus: Modus.sporty,
      );

      final selected = scheduler.selectEligibleFocusArea(
        focusAreas: [area],
        promptsUsed: const {},
        currentHour: 12,
      );

      expect(selected, isNull);
    });

    test('Modus quotas are respected per focus area', () {
      final scheduler = SchedulerEngine(random: _FixedRandom(0));

      final avslappet = _area(
        id: 'a',
        enabled: true,
        startHour: 0,
        endHour: 23,
        modus: Modus.avslappet,
      );
      final stabil = _area(
        id: 's',
        enabled: true,
        startHour: 0,
        endHour: 23,
        modus: Modus.stabil,
      );
      final sporty = _area(
        id: 'p',
        enabled: true,
        startHour: 0,
        endHour: 23,
        modus: Modus.sporty,
      );

      expect(
        scheduler
            .selectEligibleFocusArea(
              focusAreas: [avslappet],
              promptsUsed: const {'a': 0},
              currentHour: 12,
            )
            ?.id,
        'a',
      );
      expect(
        scheduler.selectEligibleFocusArea(
          focusAreas: [avslappet],
          promptsUsed: const {'a': 1},
          currentHour: 12,
        ),
        isNull,
      );

      expect(
        scheduler
            .selectEligibleFocusArea(
              focusAreas: [stabil],
              promptsUsed: const {'s': 1},
              currentHour: 12,
            )
            ?.id,
        's',
      );
      expect(
        scheduler.selectEligibleFocusArea(
          focusAreas: [stabil],
          promptsUsed: const {'s': 2},
          currentHour: 12,
        ),
        isNull,
      );

      expect(
        scheduler
            .selectEligibleFocusArea(
              focusAreas: [sporty],
              promptsUsed: const {'p': 2},
              currentHour: 12,
            )
            ?.id,
        'p',
      );
      expect(
        scheduler.selectEligibleFocusArea(
          focusAreas: [sporty],
          promptsUsed: const {'p': 3},
          currentHour: 12,
        ),
        isNull,
      );
    });

    test('overlapping active areas can both be eligible at same time', () {
      final areaA = _area(
        id: 'household',
        enabled: true,
        startHour: 16,
        endHour: 21,
        modus: Modus.stabil,
      );
      final areaB = _area(
        id: 'study',
        enabled: true,
        startHour: 18,
        endHour: 20,
        modus: Modus.avslappet,
      );

      final pickFirst = SchedulerEngine(random: _FixedRandom(0));
      final first = pickFirst.selectEligibleFocusArea(
        focusAreas: [areaA, areaB],
        promptsUsed: const {'household': 0, 'study': 0},
        currentHour: 18,
      );

      final pickSecond = SchedulerEngine(random: _FixedRandom(1));
      final second = pickSecond.selectEligibleFocusArea(
        focusAreas: [areaA, areaB],
        promptsUsed: const {'household': 0, 'study': 0},
        currentHour: 18,
      );

      expect(first?.id, 'household');
      expect(second?.id, 'study');
    });

    test(
      'when one overlapping area reached quota, other eligible area is selected',
      () {
        final scheduler = SchedulerEngine(random: _FixedRandom(0));
        final areaA = _area(
          id: 'household',
          enabled: true,
          startHour: 16,
          endHour: 21,
          modus: Modus.stabil,
        );
        final areaB = _area(
          id: 'study',
          enabled: true,
          startHour: 18,
          endHour: 20,
          modus: Modus.avslappet,
        );

        final selected = scheduler.selectEligibleFocusArea(
          focusAreas: [areaA, areaB],
          promptsUsed: const {'household': 2, 'study': 0},
          currentHour: 18,
        );

        expect(selected?.id, 'study');
      },
    );
  });
}

FocusArea _area({
  required String id,
  required bool enabled,
  required int startHour,
  required int endHour,
  required Modus modus,
}) {
  return FocusArea(
    id: id,
    name: id,
    enabled: enabled,
    startHour: startHour,
    endHour: endHour,
    modus: modus,
  );
}

class _FixedRandom implements Random {
  _FixedRandom(this._value);

  final int _value;

  @override
  bool nextBool() => _value.isEven;

  @override
  double nextDouble() => 0.0;

  @override
  int nextInt(int max) => _value % max;
}
