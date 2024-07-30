import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../data_classes/task.dart';
import '../firebase_utils.dart';

class AppConfigProvider extends ChangeNotifier{
  String appLanguage = 'en';
  ThemeMode appTheme = ThemeMode.dark;
  List<Task> taskList =[];



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

  void getAllTasksFromFireStore() async {
    QuerySnapshot<Task> querySnapshot = await FirebaseUtils.getTasksCollection().get();
    taskList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    notifyListeners();
  }

}