import 'package:flutter/material.dart';

enum CompanionSleepSoundOption {
  none,
  waves,
  birds,
  whiteNoise,
  rain,
  pinkNoise,
  campfire,
}

extension CompanionSleepSoundOptionX on CompanionSleepSoundOption {
  String get label {
    switch (this) {
      case CompanionSleepSoundOption.none:
        return 'stille';
      case CompanionSleepSoundOption.waves:
        return 'bølger';
      case CompanionSleepSoundOption.birds:
        return 'fugler';
      case CompanionSleepSoundOption.whiteNoise:
        return 'hvitstøy';
      case CompanionSleepSoundOption.rain:
        return 'regn';
      case CompanionSleepSoundOption.pinkNoise:
        return 'rosa støy';
      case CompanionSleepSoundOption.campfire:
        return 'bål';
    }
  }

  String? get assetPath {
    switch (this) {
      case CompanionSleepSoundOption.none:
        return null;
      case CompanionSleepSoundOption.waves:
        return 'sounds/sleep/Bølger.mp3';
      case CompanionSleepSoundOption.birds:
        return 'sounds/sleep/Fugler.mp3';
      case CompanionSleepSoundOption.whiteNoise:
        return 'sounds/sleep/Hvitstøy.mp3';
      case CompanionSleepSoundOption.rain:
        return 'sounds/sleep/Rein.mp3';
      case CompanionSleepSoundOption.pinkNoise:
        return 'sounds/sleep/Rosa støy.mp3';
      case CompanionSleepSoundOption.campfire:
        return 'sounds/sleep/Bål.mp3';
    }
  }
}

enum CompanionBackgroundMusicOption { none, paradiset, space, avslappet, jazz }

extension CompanionBackgroundMusicOptionX on CompanionBackgroundMusicOption {
  String get label {
    switch (this) {
      case CompanionBackgroundMusicOption.none:
        return 'ingen';
      case CompanionBackgroundMusicOption.paradiset:
        return 'paradis';
      case CompanionBackgroundMusicOption.space:
        return 'space';
      case CompanionBackgroundMusicOption.avslappet:
        return 'avslappet';
      case CompanionBackgroundMusicOption.jazz:
        return 'jazz';
    }
  }

  String? get assetPath {
    switch (this) {
      case CompanionBackgroundMusicOption.none:
        return null;
      case CompanionBackgroundMusicOption.paradiset:
        return 'sounds/background_music/Idle paradis.mp3';
      case CompanionBackgroundMusicOption.space:
        return 'sounds/background_music/Idle space.mp3';
      case CompanionBackgroundMusicOption.avslappet:
        return 'sounds/background_music/Idle avslappet.mp3';
      case CompanionBackgroundMusicOption.jazz:
        return 'sounds/background_music/Idle Jazz.mp3';
    }
  }
}

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
