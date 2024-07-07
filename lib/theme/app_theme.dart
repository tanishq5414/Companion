import 'package:companion/theme/custom_page_transistion.dart';
import 'package:companion/theme/pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    primaryColor: Pallete.whiteColor,
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Pallete.whiteColor),
      displayMedium: TextStyle(color: Pallete.whiteColor),
      displaySmall: TextStyle(color: Pallete.whiteColor),
      headlineLarge: TextStyle(color: Pallete.whiteColor),
      headlineMedium: TextStyle(color: Pallete.whiteColor),
      headlineSmall: TextStyle(color: Pallete.whiteColor),
      titleLarge: TextStyle(color: Pallete.whiteColor),
      titleMedium: TextStyle(color: Pallete.whiteColor),
      titleSmall: TextStyle(color: Pallete.whiteColor),
      bodyLarge: TextStyle(color: Pallete.whiteColor),
      bodyMedium: TextStyle(color: Pallete.whiteColor),
      bodySmall: TextStyle(color: Pallete.whiteColor),
      labelLarge: TextStyle(color: Pallete.whiteColor),
      labelMedium: TextStyle(color: Pallete.whiteColor),
      labelSmall: TextStyle(color: Pallete.whiteColor),
    ),
    pageTransitionsTheme: PageTransitionsTheme(builders: {
      TargetPlatform.android: ExtendedBlackScreenTransitionsBuilder(),
      TargetPlatform.iOS: const ZoomPageTransitionsBuilder(),
    }),
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    hoverColor: Colors.transparent,
    fontFamily: 'CircularStd',
    scaffoldBackgroundColor: Pallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Pallete.backgroundColor,
      elevation: 0,
      iconTheme: IconThemeData(color: Pallete.whiteColor), // Also set icon color in AppBar
      titleTextStyle: TextStyle(color: Pallete.whiteColor, fontSize: 18, fontWeight: FontWeight.w700),
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
    iconTheme: const IconThemeData(
      color: Pallete.whiteColor,
    ),
  );
}
