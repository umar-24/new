
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toasts{
  void toastMessages(String message){
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.green,
      textColor:  Colors.white,
      fontSize: 16,
    );
  }
  void toastMessagesAlert(String message){
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor:  Colors.white,
      fontSize: 16,
    );
  }
}
