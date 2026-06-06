import 'package:flutter/material.dart';

enum CompanionSymbolOption { none, star, moon, leaf, heart, cloud, drop }

extension CompanionSymbolOptionX on CompanionSymbolOption {
  String get label {
    switch (this) {
      case CompanionSymbolOption.none:
        return 'ingen';
      case CompanionSymbolOption.star:
        return 'stjerne';
      case CompanionSymbolOption.moon:
        return 'måne';
      case CompanionSymbolOption.leaf:
        return 'blad';
      case CompanionSymbolOption.heart:
        return 'hjerte';
      case CompanionSymbolOption.cloud:
        return 'sky';
      case CompanionSymbolOption.drop:
        return 'dråpe';
    }
  }

  String? get glyph {
    switch (this) {
      case CompanionSymbolOption.none:
        return null;
      case CompanionSymbolOption.star:
        return '✦';
      case CompanionSymbolOption.moon:
        return '☾';
      case CompanionSymbolOption.leaf:
        return '❧';
      case CompanionSymbolOption.heart:
        return '♡';
      case CompanionSymbolOption.cloud:
        return '☁';
      case CompanionSymbolOption.drop:
        return '💧';
    }
  }
}

enum CompanionBackgroundTone {
  defaultDark,
  darkBlue,
  deepGreen,
  warmGray,
  softLilac,
  mutedBeige,
}

extension CompanionBackgroundToneX on CompanionBackgroundTone {
  String get label {
    switch (this) {
      case CompanionBackgroundTone.defaultDark:
        return 'standard / default dark theme';
      case CompanionBackgroundTone.darkBlue:
        return 'mørk blå';
      case CompanionBackgroundTone.deepGreen:
        return 'dyp grønn';
      case CompanionBackgroundTone.warmGray:
        return 'varm grå';
      case CompanionBackgroundTone.softLilac:
        return 'myk lilla';
      case CompanionBackgroundTone.mutedBeige:
        return 'dempet beige';
    }
  }

  Color get scaffoldColor {
    switch (this) {
      case CompanionBackgroundTone.defaultDark:
        return const Color(0xFF060B15);
      case CompanionBackgroundTone.darkBlue:
        return const Color(0xFF081428);
      case CompanionBackgroundTone.deepGreen:
        return const Color(0xFF0A1B17);
      case CompanionBackgroundTone.warmGray:
        return const Color(0xFF1B1A1D);
      case CompanionBackgroundTone.softLilac:
        return const Color(0xFF1A1622);
      case CompanionBackgroundTone.mutedBeige:
        return const Color(0xFF1E1A16);
    }
  }
}
