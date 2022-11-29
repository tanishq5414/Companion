import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notesapp/core/error_text.dart';
import 'package:notesapp/features/auth/controller/auth_controller.dart';
import 'package:notesapp/modal/user_modal.dart';
import 'package:notesapp/router.dart';
import 'package:notesapp/theme/colors.dart';
import 'package:notesapp/features/bookmarks/bookmarks.dart';
import 'package:notesapp/features/components/snack_bar.dart';
import 'package:notesapp/features/courseView/course_view.dart';
import 'package:notesapp/features/courseView/courselistfilter.dart';
import 'package:notesapp/features/error/error_404.dart';
import 'package:notesapp/features/home/bottom_nav.dart';
import 'package:notesapp/features/notesView/notes_view.dart';
import 'package:notesapp/features/search/main_search.dart';
import 'package:notesapp/features/settings/edit_profile.dart';
import 'package:notesapp/features/auth/screens/changeEmail/changeEmail.dart';
import 'package:notesapp/features/auth/screens/loginEmail/forgot_password.dart';
import 'package:notesapp/features/auth/screens/loginPhone/login_phone.dart';
import 'package:notesapp/features/auth/screens/login_main.dart';
import 'package:notesapp/features/auth/screens/signUpEmail/signup_getemail.dart';
import 'package:notesapp/features/auth/screens/signUpEmail/signup_getpassword.dart';
import 'package:routemaster/routemaster.dart';
import 'features/auth/screens/signUpEmail/signup_main.dart';
import 'features/search/search.dart';
import 'features/auth/screens/loginEmail/login_email.dart';
// import 'features/auth/screens/loginPhone/signup_main.dart';
import 'features/home/home.dart';
import 'features/settings/settings.dart';

// import '';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const ProviderScope(child: MyApp()),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late StreamSubscription<User?> _sub;
  final _navigatorKey = GlobalKey<NavigatorState>();

  // @override
  // void initState() {
  //   super.initState();

  //   _sub = FirebaseAuth.instance.userChanges().listen((event) {
  //     _navigatorKey.currentState!.pushReplacementNamed(
  //       event != null ? 'home' : 'login',
  //     );
  //   });
  // }

  // @override
  // void dispose() {
  //   _sub.cancel();
  //   super.dispose();
  // }

  UserCollection? userModel;

  void getData(WidgetRef ref, User data) async {
    userModel = await ref.watch(authControllerProvider.notifier).getUserData(data.uid).first;
    ref.read(userProvider.notifier).update((state) => userModel);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateProvider).when(
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          data: (data) => MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Montserrat',
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
            routeInformationParser: const RoutemasterParser(),
            routerDelegate: RoutemasterDelegate(
              routesBuilder: (context) {
                if (data != null) {
                  getData(ref, data);
                  if (userModel != null) {
                    return loggedInPages;
                  }
                }
                return loggedOutPages;
              },
            ),
          ),
        );
  }
}

