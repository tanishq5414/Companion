import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/config/colors.dart';
import 'package:notesapp/pages/bookmarks/bookmarks.dart';
import 'package:notesapp/pages/components/snack_bar.dart';
import 'package:notesapp/pages/courseView/course_view.dart';
import 'package:notesapp/pages/error/error_404.dart';
import 'package:notesapp/pages/home/bottom_nav.dart';
import 'package:notesapp/pages/notesView/notes_view.dart';
import 'package:notesapp/pages/search/main_search.dart';
import 'package:notesapp/pages/settings/edit_profile.dart';
import 'package:notesapp/pages/userAuthentication/loginEmail/forgot_password.dart';
import 'package:notesapp/pages/userAuthentication/loginPhone/login_phone.dart';
import 'package:notesapp/pages/userAuthentication/login_main.dart';
import 'package:notesapp/pages/userAuthentication/signUpEmail/signup_getemail.dart';
import 'package:notesapp/pages/userAuthentication/signUpEmail/signup_getpassword.dart';
import 'package:notesapp/provider/get_courses.dart';
import 'package:notesapp/provider/get_notes.dart';
import 'package:provider/provider.dart';
import 'provider/firebase_auth_methods.dart';
import 'pages/search/search.dart';
import 'pages/userAuthentication/loginEmail/login_email.dart';
import 'pages/userAuthentication/signUpEmail/signup_main.dart';
import 'pages/home/home.dart';
import 'pages/settings/settings.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<User?> _sub;
  final _navigatorKey = GlobalKey<NavigatorState>();

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
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
          create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<FirebaseAuthMethods>().authState,
          initialData: null,
        ),
        StreamProvider(
          create: (BuildContext context) {
            GetCourses.getCourses();
          },
          initialData: null,
        ),
        StreamProvider(
            create: (BuildContext context) {
              GetNotes.getNotes();
            },
            initialData: null),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Gotham',
          primaryColor: Colors.black,
          scaffoldBackgroundColor: appBackgroundColor,
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: appBlackColor,
            selectionColor: appAccentColor,
            selectionHandleColor: Colors.black,
          ),
          primarySwatch: primaryBlack,
        ),
        scaffoldMessengerKey: Utils.messengerKey,
        routes: <String, WidgetBuilder>{
          '/search': (context) => const SearchPage(),
          '/login': (context) => const LoginPage(),
          '/phonelogin': (context) => const PhoneLogin(),
          '/start': (context) => const LoginMain(),
          '/signup': (context) => const SignupPage(),
          '/home': (context) => const HomePage(),
          '/settings': (context) => const SettingsPage(),
          '/bookmarks': (context) => const BookmarksPage(),
          '/emailpage': (context) => const EmailPage(),
          '/passwordpage': (context) => const PasswordPage(),
          '/forgotpassword': (context) => const ForgotPasswordPage(),
          '/pdfview': (context) => NotesViewPage(),
          '/courseview': (context) => CourseViewPage(),
          '/editprofile': (context) => EditProfile(),
          '/error404': (context) => const Error404(),
          '/mainsearch': (context) => const MainSearchPage(),
        },
        navigatorKey: _navigatorKey,
        initialRoute:
            FirebaseAuth.instance.currentUser == null ? 'login' : 'home',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case 'home':
              return MaterialPageRoute(
                settings: settings,
                builder: (_) => const AppBottomNavigator(),
              );
            case 'login':
              return MaterialPageRoute(
                settings: settings,
                builder: (_) => const LoginMain(),
              );
            default:
              return MaterialPageRoute(
                settings: settings,
                builder: (_) => const Error404(),
              );
          }
        },
      ),
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
              return const LoginMain();
            }
          },
        ),
      );
}
