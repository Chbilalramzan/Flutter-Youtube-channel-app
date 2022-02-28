import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_shouket/src/localization/translator_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

String getTranslated(BuildContext context, String key) {
  return TranslatorLocalization.of(context).getTranslatedValue(key);
}

// language constant

const String ENGLISH = 'en';
const String URDU = 'ur';

// language code
const String LANGUAGE_CODE = 'languageCode';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LANGUAGE_CODE, languageCode);

  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  Locale _temp;
  switch (languageCode) {
    case ENGLISH:
      _temp = Locale(languageCode, 'AU');
      break;
    case URDU:
      _temp = Locale(languageCode, 'PK');
      break;
    default:
      _temp = Locale(ENGLISH, 'AU');
  }
  return _temp;
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.get(LANGUAGE_CODE) ?? ENGLISH;
  return _locale(languageCode);
}
