import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TranslatorLocalization {
  final Locale locale;

  TranslatorLocalization(this.locale);

  // Helper method to keep the code in the widget concise
  // Localisations are accessed using an InheritedWidget "of" syntax
  static TranslatorLocalization of(BuildContext context) {
    return Localizations.of<TranslatorLocalization>(
        context, TranslatorLocalization);
  }

  // static member of Translatorlocalization to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<TranslatorLocalization> delegate =
      _TranslatorLocalizationDelegate();

  Map<String, String> _localizedValues;

  Future load() async {
    String jsonStringValues =
        await rootBundle.loadString('lib/src/lang/${locale.languageCode}.json');

    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);

    _localizedValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  // This method will be called from every widget which means a localized text

  String getTranslatedValue(String key) {
    return _localizedValues[key];
  }
}

// LocalizationDelegate is a factory of a set of localised resources
// In this case, the localised value will be gotten in an TranslatorLocalisation object

class _TranslatorLocalizationDelegate
    extends LocalizationsDelegate<TranslatorLocalization> {
  // This delegate instance will never change (it does not even have fields)
  // It can provide a constant constructor.

  const _TranslatorLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of the supported language codes here:
    return ['ur', 'en'].contains(locale.languageCode);
  }

  @override
  Future<TranslatorLocalization> load(Locale locale) async {
    //TranslatorLocalizations class is where the Json loading actually runs
    TranslatorLocalization localization = TranslatorLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(_TranslatorLocalizationDelegate old) => false;
}
