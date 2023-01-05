import 'package:flutter/material.dart';
import 'package:notesapp/features/auth/screens/loginEmail/forgot_password.dart';
import 'package:notesapp/features/auth/screens/loginEmail/login_email.dart';
import 'package:notesapp/features/auth/screens/login_main.dart';
import 'package:notesapp/features/auth/screens/signUpEmail/signup_getemail.dart';
import 'package:notesapp/features/auth/screens/signUpEmail/signup_getpassword.dart';
import 'package:notesapp/features/auth/screens/signUpEmail/signup_main.dart';
import 'package:notesapp/features/bookmarks/bookmarks.dart';
import 'package:notesapp/features/courseView/course_view.dart';
import 'package:notesapp/features/courseView/courselistfilter.dart';
import 'package:notesapp/features/error/error_404.dart';
import 'package:notesapp/features/home/bottom_nav.dart';
import 'package:notesapp/features/home/home.dart';
import 'package:notesapp/features/notesView/notes_view.dart';
import 'package:notesapp/features/search/main_search.dart';
import 'package:notesapp/features/search/search.dart';
import 'package:notesapp/features/settings/edit_profile.dart';
import 'package:notesapp/features/settings/settings.dart';
import 'package:routemaster/routemaster.dart';

import 'features/auth/screens/send_email_verification.dart';

final loggedOutPages = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(child: LoginMain()),
    '/signup': (_) => const MaterialPage(child: SignupPage()),
    '/login': (_) => const MaterialPage(child: LoginPage()),
    '/emailpage': (_) => const MaterialPage(child: EmailPage()),
    '/passwordpage/:email': (route) => MaterialPage(child: PasswordPage(
          email: route.pathParameters['email']!,
    )),
    '/forgotpassword': (_) => const MaterialPage(child: ForgotPasswordPage()),
    '/sendverification': (_) => const MaterialPage(child: SendEmailVerification()),
  },
);

final loggedInPages = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(child: AppBottomNavigator()),
    '/settings': (_) => const MaterialPage(child: SettingsPage()),
    '/search': (_) => const MaterialPage(child: SearchPage()),
    '/home': (_) => const MaterialPage(child: HomePage()),
    '/bookmarks': (_) => const MaterialPage(child: BookmarksPage()),
    '/sendverification': (_) => const MaterialPage(child: SendEmailVerification()),
    '/pdfview': (_) => const MaterialPage(child: NotesViewPage()),
    '/courseview': (_) => const MaterialPage(child: CourseViewPage()),
    '/editprofile': (_) => const MaterialPage(child: EditProfile()),
    '/error404': (_) => const MaterialPage(child: Error404()),
    '/mainsearch': (_) => const MaterialPage(child: MainSearchPage()),
    '/courselistfilter': (_) => const MaterialPage(child: CourseListFilterPage()),
  },
);
