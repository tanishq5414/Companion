import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/screens/Login/GreetingPage1.dart';
import 'package:notesapp/utils/utils.dart';
import 'package:notesapp/utils/utils.dart';
import './screens/search.dart';
import 'screens/Login/GreetingPage2.dart';
import 'screens/Login/GreetingPage3.dart';
import 'screens/Login/GreetingPage1.dart';
import 'screens/Login/loginPage.dart';
import 'screens/Login/signUp/signupPage.dart';
import 'home.dart';
import 'utils/utils.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<User?> _sub;
  final _navigatorKey = new GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    _sub = FirebaseAuth.instance.userChanges().listen((event) {
      _navigatorKey.currentState!.pushReplacementNamed(
        event != null ? 'home' : 'login',
      );
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Gotham',
      ),
      scaffoldMessengerKey: Utils.messengerKey,
      routes: <String, WidgetBuilder>{
        '/search': (context) => const Search(),
        '/login': (context) => const LoginPage(),
        '/greeting1': (context) => const GreetingPage1(),
        '/greeting2': (context) => const GreetingPage2(),
        '/greeting3': (context) => const GreetingPage3(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomePage(),
      },
      navigatorKey: _navigatorKey,
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? 'login' : 'home',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case 'home':
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => HomePage(),
            );
          case 'login':
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => GreetingPage1(),
            );
          default:
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => UnknownPage(),
            );
        }
      },
    );
  }
}

class UnknownPage extends StatefulWidget {
  const UnknownPage({Key? key}) : super(key: key);

  @override
  _UnknownPageState createState() => _UnknownPageState();
}

class _UnknownPageState extends State<UnknownPage> {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.red);
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return const HomePage();
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong'),
              );
            } else {
              return const LoginPage();
            }
          },
        ),
      );
}
