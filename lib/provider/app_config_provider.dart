
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../data_classes/task.dart';
import '../firebase_utils.dart';

class AppConfigProvider extends ChangeNotifier{
  String appLanguage = 'en';
  ThemeMode appTheme = ThemeMode.light;
  List<Task> taskList =[];
  DateTime selectDate = DateTime.now();
  bool isDone = false;
  String newTitle = '';
  String newDescription = '';
  DateTime newDate = DateTime.now();

  String testDesc = '';
  String testTitle = '';



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

  void getAllTasksFromFireStore(String uId) async {
    QuerySnapshot<Task> querySnapshot = await FirebaseUtils.getTasksCollection(uId).get();
    taskList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    //filtering tasks
    taskList = taskList.where((task) {
      if(selectDate.day == task.dateTime.day &&
      selectDate.month == task.dateTime.month &&
      selectDate.year == task.dateTime.year){
        return true;
      }
      return false;
    }).toList();

    //sorting tasks
    taskList.sort((Task task1 , Task task2){
     return task1.dateTime.compareTo(task2.dateTime);
    });

    notifyListeners();
  }

  void changeSelectDate(DateTime mewSelectData,String uId){
    selectDate = mewSelectData;
    getAllTasksFromFireStore(uId);
  }


}