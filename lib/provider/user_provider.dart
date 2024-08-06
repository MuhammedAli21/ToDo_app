import 'package:flutter/foundation.dart';

import '../data_classes/my_user.dart';

class UserProvider extends ChangeNotifier{
  ///data

  MyUser? currentUser;

  void updateUser(MyUser newUser){
    currentUser = newUser;
    notifyListeners();
  }
}