// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';
import 'package:companion_rebuild/core/keys/supabase_api_keys.dart';
import 'package:companion_rebuild/core/error_text.dart';
import 'package:companion_rebuild/core/provider/firebase_providers.dart';
import 'package:companion_rebuild/features/auth/controller/auth_controller.dart';
import 'package:companion_rebuild/features/components/dynamicLinks/firebase_dynamic_links.dart';
import 'package:companion_rebuild/modal/user_modal.dart';
import 'package:companion_rebuild/router.dart';
import 'package:companion_rebuild/theme/colors.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:routemaster/routemaster.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import 'features/components/snack_bar.dart';

// import 'features/dynamicLinks/firebase_dynamic_links.dart';


Future main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  var b = FirebaseAuth.instance;
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

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateProvider).when(
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          data: (data) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                splashFactory: NoSplash.splashFactory,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                fontFamily: 'CircularStd',
                primaryColor: Colors.black,
                scaffoldBackgroundColor: appBackgroundColor,
                textTheme: Theme.of(context).textTheme.apply(
                      bodyColor: Colors.white,
                      displayColor: Colors.white,
                      fontFamily: 'CircularStd',
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
                    getData(WidgetRef ref, User data) async {
                      var u1 = userModel;
                      userModel = await ref
                          .watch(authControllerProvider.notifier)
                          .getUserData(data.uid)
                          .first;
                      ref
                          .read(userProvider.notifier)
                          .update((state) => userModel);
                      FlutterNativeSplash.remove();
                      // if (u1 == null) {
                      //   setState(() {});
                      // }
                    }

                    getData(ref, data);
                    return loggedInPages;
                  }
                  FlutterNativeSplash.remove();
                  return loggedOutPages;
                },
              ),
            );
          },
        );
  }
}
