import 'package:flutter/material.dart';
import './screens/search.dart';
import 'home.dart';
void main() {
  runApp(const MyApp() );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => Home(),
        '/search': (context) => const Search(),
      },
    );
  }
}
