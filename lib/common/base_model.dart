import 'package:flutter/material.dart';

class BaseModel with ChangeNotifier {
  bool loading = false;

  void loadingg(bool loading) {
    this.loading = loading;
    notifyListeners();
  }
}
