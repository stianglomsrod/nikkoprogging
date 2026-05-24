enum Modus { avslappet, stabil, sporty }

extension ModusX on Modus {
  int get maxPrompts {
    switch (this) {
      case Modus.avslappet:
        return 1;
      case Modus.stabil:
        return 2;
      case Modus.sporty:
        return 3;
    }
  }

  String get label {
    switch (this) {
      case Modus.avslappet:
        return 'avslappet';
      case Modus.stabil:
        return 'stabil';
      case Modus.sporty:
        return 'sporty';
    }
  }
}
