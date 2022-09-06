import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/screens/Login/GreetingPage1.dart';
import './screens/search.dart';
import 'screens/Login/GreetingPage2.dart';
import 'screens/Login/GreetingPage3.dart';
import 'screens/Login/GreetingPage1.dart';
import 'screens/Login/loginPage.dart';
import 'screens/Login/signupPage.dart';
import 'home.dart';

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
      initialRoute: '/greeting1',
      routes: <String, WidgetBuilder>{
        '/search': (context) => const Search(),
        '/login': (context) => const LoginPage(),
        '/greeting1': (context) => const GreetingPage1(),
        '/greeting2': (context) => const GreetingPage2(),
        '/greeting3': (context) => const GreetingPage3(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
