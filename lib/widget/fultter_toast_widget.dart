import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toast {
  static void showToast(String msg, ErrorLevel errorLevel) {
    Color color = Color(0xFF00B6F0);
    switch (errorLevel) {
      case ErrorLevel.Warning:
        color = Color(0xFFF7AB00);
        break;
      case ErrorLevel.Error:
        color = Color(0xFFFF0000);
        break;
      default:
        color = Color(0xFF00B6F0);
        break;
    }
    Fluttertoast.showToast(
        msg: msg,
        //  toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

enum ErrorLevel { Warning, Error, Success }
