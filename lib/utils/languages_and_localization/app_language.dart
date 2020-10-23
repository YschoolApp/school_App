import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = Locale('en');

  String currentLangCode;
  String currentLangName;

  Locale get appLocal => _appLocale ?? Locale('en');

  set appLocale(Locale value){
    _appLocale = value;
    notifyListeners();
  }

  Box<String> appLangBox;

  fetchLocale() async {
    appLangBox = await Hive.openBox('appLanguage');

    if (appLangBox.get('language_code') == null) {

      final String defaultLocale = Platform.localeName;

      if (defaultLocale.contains('ar')) {
        _appLocale = Locale('ar');
        currentLangCode = 'ar';
        currentLangName = 'العربية';
        return Null;
      }

      _appLocale = Locale('en');
      currentLangCode = 'en';
      currentLangName = 'English';
      return Null;
    }

    _appLocale = Locale(appLangBox.get('language_code'));
    if (appLangBox.get('language_code') == 'en') {
      currentLangCode = 'en';
      currentLangName = 'English';
    }
    if (appLangBox.get('language_code') == 'ar') {
      currentLangCode = 'ar';
      currentLangName = 'العربية';
    }
    return Null;
  }

  void changeLanguage(Locale type) async {

    print('new lan is $type');

    if (_appLocale == type) {
      return;
    }
    if (type == Locale("ar")) {
      currentLangCode = 'ar';
      currentLangName = 'العربية';
      appLocale = Locale("ar");
      appLangBox.put('language_code', 'ar');
      appLangBox.put('countryCode', '');
    } else {
      appLocale = Locale("en");
      currentLangCode = 'en';
      currentLangName = 'English';
      appLangBox.put('language_code', 'en');
      appLangBox.put('countryCode', 'US');
    }
  }
}
