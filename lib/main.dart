import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/screens/Login/GreetingPage1.dart';
import './screens/search.dart';
import 'home.dart';
import 'screens/Login/GreetingPage2.dart';
import 'screens/Login/GreetingPage3.dart';
import 'screens/Login/GreetingPage1.dart';
import 'screens/Login/loginPage.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(DevicePreview(
    enabled: true,
    builder: (context) => MyApp()));
}

class MyApp extends StatelessWidget {
  //CHECKING COMMIT
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      routes: <String, WidgetBuilder>{
        '/home': (context) => LoginDemo(),
        '/search': (context) => const Search(),
      },
    );
  }
}
