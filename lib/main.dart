import 'package:companion/features/hive/boxes.dart';
import 'package:companion/features/hive/model/recentlyaccessed.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:companion/features/auth/controller/auth_controller.dart';
import 'package:companion/theme/app_theme.dart';

import '../firebase_options.dart';
import 'common/common.dart';
import 'features/auth/views/login_view.dart';
import 'features/home/views/nav_view.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(RecentlyAccessedAdapter());
  recentlyAccessedBox = await Hive.openBox<List>('recentlyaccessed');
  trendingBox = await Hive.openBox<String>('trending');
  networkCache = await Hive.openBox<List>('networkcache');
  userCache = await Hive.openBox<String>('usercache');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Companion',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: ref.watch(authStateProvider).when(
          data: (user) {
            if (user != null) {
              return NavView(
                firebaseUser: user,
              );
            }
            return const LoginView();
          },
          error: (error, st) => ErrorPage(error: error.toString()),
          loading: () {
            return const LoadingPage();
          }),
    );
  }
}
