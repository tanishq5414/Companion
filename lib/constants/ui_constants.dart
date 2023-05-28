import 'package:flutter/material.dart';

import '../theme/pallete.dart';

class UIConstants {
  static List<Widget> bottomTabBarPages = [
    const Text('Home Screen'),
    const Text('Search Screen'),
    const Text('Notification Screen'),
    const Text('Profile'),
  ];

  // create text styles according to how it is used in app
  static const TextStyle kHeadingTextStyle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle kSubHeadingTextStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
  );

  static final List<Color> lightColors = [
    Pallete.redColor,
    Pallete.blueColor,
    Pallete.brownColor,
    Pallete.violetColor,
    Pallete.yellowColor,
    Pallete.greenColor,
    Pallete.purpleColor,
    Pallete.purpleColor,
    Pallete.purpleColor,
    Pallete.purpleColor,
  ];
  static final List<Color> darkColors = [
    Pallete.deepRedColor,
    Pallete.deepBlueColor,
    Pallete.deepBrownColor,
    Pallete.deepVioletColor,
    Pallete.deepYellowColor,
    Pallete.deepGreenColor,
    Pallete.deepPurpleColor,
    Pallete.deepPurpleColor,
    Pallete.deepPurpleColor,
    Pallete.deepPurpleColor,
  ];

  static List<String> branchDetails = [
    'CSE',
    'ECE',
    'EEE',
    'CIVIL',
    'MECH',
    'IT',
    'MBA',
    'MCA',
    'CSIT',
    'AIML',
    'CSE AI&ML',
    'CS DS',
    'CSC',
  ];
}
