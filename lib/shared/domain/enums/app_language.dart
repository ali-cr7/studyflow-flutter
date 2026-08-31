

enum AppLanguage {
  en,
  ar,
}

extension AppLanguageLocale on AppLanguage {
  String get localeCode {
    switch (this) {
      case AppLanguage.en:
        return 'en';
      case AppLanguage.ar:
        return 'ar';
    }
  }
}
