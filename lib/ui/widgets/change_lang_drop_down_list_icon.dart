import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_app/utils/languages_and_localization/app_language.dart';
import 'package:school_app/utils/languages_and_localization/languages_list.dart';
import '../../locator.dart';


Padding changeLanguageDropDownList() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: DropdownButton<LanguageListModel>(
      isExpanded: false,
      underline: SizedBox(),
      icon: Icon(
        Icons.language,
        color: Colors.white,
      ),
      items: LanguageListModel.myDropDownMenuItem(),
      onChanged: (LanguageListModel language) {
        locator<AppLanguage>().changeLanguage(Locale(language.languageCode));
      },
    ),
  );
}
