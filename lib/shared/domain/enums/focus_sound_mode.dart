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

  /// Returns the asset path for this sound, or null when no sound is selected.
  /// The file must exist at `assets/sounds/<name>.mp3` (placed by the user).
  String? get assetPath {
    switch (this) {
      case FocusSoundMode.none:
        return null;
      case FocusSoundMode.rain:
        return 'assets/sounds/rain.m4a';
      case FocusSoundMode.ocean:
        return 'assets/sounds/ocean.mp3';
      case FocusSoundMode.forest:
        return 'assets/sounds/forest.mp3';
      case FocusSoundMode.cafe:
        return 'assets/sounds/cafe.mp3';
    }
  }

  /// Icon to represent this sound mode in the UI.
  String get iconName {
    switch (this) {
      case FocusSoundMode.none:
        return 'volume_off';
      case FocusSoundMode.rain:
        return 'water_drop';
      case FocusSoundMode.ocean:
        return 'waves';
      case FocusSoundMode.forest:
        return 'park';
      case FocusSoundMode.cafe:
        return 'local_cafe';
    }
  }
}
