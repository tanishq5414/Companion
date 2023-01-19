// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:notesapp/apikeys.dart';
import 'package:notesapp/core/error_text.dart';
import 'package:notesapp/features/auth/controller/auth_controller.dart';
import 'package:notesapp/modal/user_modal.dart';
import 'package:notesapp/router.dart';
import 'package:notesapp/theme/colors.dart';
import 'package:notesapp/features/components/snack_bar.dart';
import 'package:routemaster/routemaster.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import 'features/dynamicLinks/firebase_dynamic_links.dart';

Future main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  MobileAds.instance.initialize();
  await supabase.Supabase.initialize(
    url: supabaseApiURL,
    anonKey: supabaseApiPublicKey,
  );
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
  UserCollection? userModel;

  getData(WidgetRef ref, User data) async {
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(data.uid)
        .first;
    FlutterNativeSplash.remove();
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
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent ,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              fontFamily: 'Montserrat',
              primaryColor: Colors.black,
              scaffoldBackgroundColor: appBackgroundColor,
              textTheme: Theme.of(context).textTheme.apply(
                    bodyColor: Colors.white,
                    displayColor: Colors.white,
                  ),
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
                if (data != null && data.emailVerified == true) {
                  initialization() async {
                    await getData(ref, data);
                    FlutterNativeSplash.remove();
                  }

                  initialization();
                  if (userModel != null) {
                    return loggedInPages;
                  }
                }
                FlutterNativeSplash.remove();
                return loggedOutPages;
              },
            ),
          ),
        );
  }
}
