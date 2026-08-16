enum FocusSoundMode { none, rain, ocean, forest, cafe }

extension FocusSoundModeLabel on FocusSoundMode {
  String get label {
    switch (this) {
      case FocusSoundMode.none:
        return 'No sound';
      case FocusSoundMode.rain:
        return 'Rain';
      case FocusSoundMode.ocean:
        return 'Ocean';
      case FocusSoundMode.forest:
        return 'Forest';
      case FocusSoundMode.cafe:
        return 'Cafe';
    }
  }
}
