import 'package:companion/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';


class AppTheme {
  static ThemeData theme = ThemeData(
    //default text coor
    primaryColor: Pallete.whiteColor,
    
    textTheme: const TextTheme(
      
    ),
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    // pageTransitionsTheme: PageTransitionsTheme(
    //   builders: {
    //     TargetPlatform.android: PageTransition(),
    //     TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    //   },
    // ),
    hoverColor: Colors.transparent,
    fontFamily: 'CircularStd',
    scaffoldBackgroundColor: Pallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Pallete.backgroundColor,
      elevation: 0,
    ),
    primaryTextTheme: const TextTheme(
      headline6: TextStyle(
        color: Pallete.whiteColor,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Pallete.greenColor,
    ),
  );
}
