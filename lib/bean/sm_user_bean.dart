import 'package:flutter/cupertino.dart';

class SmUserBean with ChangeNotifier {
  String usercode;
  String username;
  String password;
  String token;

  void updateUsername(String usercode) {
    this.usercode = usercode;
    notifyListeners();
  }

  void updatePass(String password) {
    this.password = password;
    notifyListeners();
  }
}
