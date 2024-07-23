import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier{
  String appLanguage = 'en';
  ThemeMode appTheme = ThemeMode.dark;

  void selectedLanguage(String newLanguage){
    if(appLanguage == newLanguage){
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();
  }

  void selectedTheme(ThemeMode newTheme){
    if(appTheme == newTheme){
      return;
    }
    appTheme = newTheme;
    notifyListeners();
  }

  bool isDarkmode(){
    return appTheme == ThemeMode.dark;
  }
}