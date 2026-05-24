enum Sinnsstemning { negativ, ok, energisk }

extension SinnsstemningX on Sinnsstemning {
  String get label {
    switch (this) {
      case Sinnsstemning.negativ:
        return 'negativ';
      case Sinnsstemning.ok:
        return 'ok';
      case Sinnsstemning.energisk:
        return 'energisk';
    }
  }
}
