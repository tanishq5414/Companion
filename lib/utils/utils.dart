import 'package:flutter/material.dart';
class Utils{
  static final GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();
  static showSnackBar(String? text){
    if(text == null) return;

    final snackBar = SnackBar(
      content: Text(text),
      duration: Duration(seconds: 2),
    );
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}