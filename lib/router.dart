import 'package:companion_rebuild/features/admin/addnotesdata.dart';
import 'package:companion_rebuild/features/auth/screens/changepassword/changepassword.dart';
import 'package:companion_rebuild/features/notes/notes_info.dart';
import 'package:companion_rebuild/features/notes/notes_menu.dart';
import 'package:companion_rebuild/features/premium/premiumpage.dart';
import 'package:companion_rebuild/features/premium/premiumstatuspage.dart';
import 'package:companion_rebuild/features/privacypolicy/privacypolicy.dart';
import 'package:companion_rebuild/features/recents/recentlyaccessed.dart';
import 'package:routemaster/routemaster.dart';
import 'package:companion_rebuild/features/admin/addnotes.dart';
import 'package:companion_rebuild/features/auth/screens/login_main.dart';
import 'package:companion_rebuild/features/auth/screens/signUpEmail/signup_main.dart';
import 'package:companion_rebuild/features/bookmarks/bookmarks.dart';
import 'package:companion_rebuild/features/courseView/course_view.dart';
import 'package:companion_rebuild/features/courseView/courselistfilter.dart';
import 'package:companion_rebuild/features/error/error_404.dart';
import 'package:companion_rebuild/features/home/bottom_nav.dart';
import 'package:companion_rebuild/features/home/home.dart';
import 'package:companion_rebuild/features/search/main_search.dart';
import 'package:companion_rebuild/features/search/search.dart';
import 'package:companion_rebuild/features/settings/edit_profile.dart';
import 'package:companion_rebuild/features/settings/settings.dart';
import 'package:flutter/material.dart';


import 'features/auth/screens/loginEmail/forgot_password.dart';
import 'features/auth/screens/loginEmail/login_email.dart';
import 'features/auth/screens/send_email_verification.dart';
import 'features/auth/screens/signUpEmail/signup_getemail.dart';
import 'features/auth/screens/signUpEmail/signup_getpassword.dart';
import 'features/bookmarks/bookmarks_search.dart';
import 'features/notesView/notes_view.dart';

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
    '/forgotpassword': (_) => const MaterialPage(child: ForgotPasswordPage()),
    '/sendverification': (_) => const MaterialPage(child: SendEmailVerification()),
    '/pdfview': (_) => const MaterialPage(child: NotesViewPage()),
    '/addnotes': (_) => const MaterialPage(child: AddNotes()),
    '/notesmenu': (_) => const MaterialPage(child: NotesMenu()),
    '/notesinfo': (_) => const MaterialPage(child: NotesInfo()),
    '/premiumstatus': (_) => const MaterialPage(child: PremiumStatus()),
    '/recentlyaccessed': (_) => const MaterialPage(child: RecentlyAccessedPage()),
    '/addnotesdata': (_) => const MaterialPage(child: AddNotesDetails()),
    '/courseview': (_) => const MaterialPage(child: CourseViewPage()),
    '/editprofile': (_) => const MaterialPage(child: EditProfile()),
    '/error404': (_) => const MaterialPage(child: Error404()),
    '/mainsearch': (_) => const MaterialPage(child: MainSearchPage()),
    '/courselistfilter': (_) => const MaterialPage(child: CourseListFilterPage()),
    '/premium': (_) => const MaterialPage(child: PremiumPage()),
    '/privacypolicy': (_) => const MaterialPage(child: PrivacyPolicyPage()),
    '/changepassword': (_) => const MaterialPage(child: ChangePasswordPage()),
    '/bookmarksearchpage': (_) => const MaterialPage(child: BookmarksSearchPage()),
  },
);

