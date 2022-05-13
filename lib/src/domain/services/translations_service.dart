import 'package:humble_sand/generated/l10n.dart';
import 'package:humble_sand/src/domain/services/shared_preferences_service.dart';
import 'package:humble_sand/src/locator_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class _Keys {
  static const languageCodeCatalan = "ca_ES";
  static const languageCodeSpanish = "es_ES";
}

class TranslationsService {
  final List<String> supportedLocales =
      S.delegate.supportedLocales.map((e) => e.toString()).toList();

  String get currentLanguage {
    return Intl.getCurrentLocale();
  }

  String keyToString(key, BuildContext context) {
    switch (key) {
      case _Keys.languageCodeCatalan:
        return "";
      //return S.of(context).catalanLanguage;
      case _Keys.languageCodeSpanish:
        return "";
      //return S.of(context).spanishLanguage;
      default:
        return "";
    }
  }

  Future<void> loadLanguage() async {
    String? languageCode = locator<SharedPreferencesService>().getLanguage();
    if (languageCode != null) {
      var langSplitted = languageCode.split("_");
      if (langSplitted.length > 1) {
        await S.load(Locale(langSplitted[0], langSplitted[1]));
      } else {
        await S.load(Locale(langSplitted[0]));
      }
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    var langSplitted = languageCode.split("_");
    if (langSplitted.length > 1) {
      await S.load(Locale(langSplitted[0], langSplitted[1]));
    } else {
      await S.load(Locale(langSplitted[0]));
    }
    locator<SharedPreferencesService>().saveLanguage(languageCode);
  }
}
