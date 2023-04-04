import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/l10n/locales.dart';
import 'package:todo_app_main_screen/main.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? _locale = currentUser.locale>=0 ? Locales.allLocales[currentUser.locale] : null;

  Locale? get locale => _locale;

  void setLocale(Locale locale) {
    if (!Locales.allLocales.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }

}
