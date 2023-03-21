// ignore_for_file: depend_on_referenced_packages, unused_import, use_build_context_synchronously, unused_local_variable, deprecated_member_use

import 'dart:math';

import 'package:companion_rebuild/core/failure.dart';
import 'package:companion_rebuild/core/provider/firebase_providers.dart';
import 'package:companion_rebuild/core/type_defs.dart';
import 'package:companion_rebuild/features/auth/controller/auth_controller.dart';
import 'package:companion_rebuild/features/components/snack_bar.dart';
import 'package:companion_rebuild/modal/user_modal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod/riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../components/otp_box.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    supabaseClient: ref.read(supabaseProvider),
    auth: ref.read(authProvider),
    googleSignIn: ref.read(googleSignInProvider),
  ),
);

class AuthRepository {
  final supabase.SupabaseClient _supabaseClient;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  AuthRepository({
    required supabase.SupabaseClient supabaseClient,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        _supabaseClient = supabaseClient,
        _googleSignIn = googleSignIn;

  User get user => _auth.currentUser!;
  List<String> cid = [
    "858411776",
    "198294998",
    "789059098",
    "350606284",
    "534108627",
    "518695126"
  ];
  Stream<User?> get authStateChange => _auth.authStateChanges();

  // EMAIL SIGN UP
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String fullName,
    required BuildContext context,
  }) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await sendEmailVerification(context);
      Routemaster.of(context).push('/sendverification');
      await _supabaseClient.from('userscollection').insert({
        'uid': result.user!.uid,
        'cid': cid,
        'bid': [],
        'email': user.email,
        'name': fullName,
        'photoUrl': user.photoURL ?? "",
        'notificationsEnabled': "true",
        'isAdmin': false,
        'isPremiumUser': true,
        'recentlyAccessed': [],
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Utils.showSnackBar('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Utils.showSnackBar('The account already exists for that email.');
      } else {
        Utils.showSnackBar(
            'Some error occurred try again in some time if it still persists contact us');
      }
    }
  }

  //add courses
  Future<String> updateUserCourses(String uid, List cid) async {
    String res = "Some error occurred";
    try {
      await _supabaseClient.from('userscollection').update({
        'cid': cid,
      }).eq('uid', uid);
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Bookmark Notes
  Future<String> bookmarkNotes(String id, bookmarks) async {
    var user = getUserData(id);
    bookmarks = bookmarks.toSet().toList();
    String res = "Some error occurred";
    try {
      await _supabaseClient.from('userscollection').update({
        'bid': bookmarks,
      }).eq('uid', id);
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // EMAIL LOGIN
  FutureEither<UserCollection> loginWithEmail(
      {required String email,
      required String password,
      required BuildContext context,
      required WidgetRef ref}) async {
    late UserCollection userModel;
    try {
      var userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      var user = userCredential.user!;
      if (user.emailVerified == false) {
        await sendEmailVerification(context);
        Routemaster.of(context).push('/sendverification');
        Utils.showSnackBar(
            'Please verify your email first. Verification link sent to $email');
        return left(Failure('Please verify your email first'));
      } else {
        Routemaster.of(context).popUntil((routeData) => false);
        userModel = await ref
            .watch(authControllerProvider.notifier)
            .getUserData(
              user.uid,
            )
            .first;
        return right(userModel);
      }
    } //wrong password exception
    on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Utils.showSnackBar('No user found for the email provided.');
      } else if (e.code == 'wrong-password') {
        Utils.showSnackBar('Password is incorrect.');
      } else {
        Utils.showSnackBar(
            'Some error occurred try again in some time if it still persists contact us');
      }
      print(e.message);
      throw e.message!;
    }
  }

  incrementnotesopened(String uid, String notesid, String notesname,
      String course, String unit) async {
    List data1 = await _supabaseClient
        .from('userscollection')
        .select('recentlyAccessed')
        .eq('uid', uid);
    List data2 = data1[0]['recentlyAccessed'];
    data2.add(notesid);
    if (data2.length > 30) {
      data2 = data2.sublist(data2.length - 30, data2.length);
    }
    await _supabaseClient.from('userscollection').update({
      'recentlyAccessed': data2,
    }).eq('uid', uid);

    var data = await _supabaseClient
        .from('notesdata')
        .select('times_opened')
        .eq('id', notesid);
    if (data.length == '0' || data.length == 0) {
      await _supabaseClient.from('notesdata').insert({
        'id': notesid,
        'times_opened': 1,
        'notesname': notesname,
        'course': course,
        'unit': unit,
      });
      return;
    } else {
      var timesopened = data[0]['times_opened'];
      await _supabaseClient.from('notesdata').update({
        'times_opened': timesopened + 1,
      }).eq('id', notesid);
    }
  }

  //RESET PASSWORD
  Future<void> resetPassword({
    required String email,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Utils.showSnackBar('Password Reset Email Sent');
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message!);
    }
  }

  // EMAIL VERIFICATION
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      Utils.showSnackBar('Email Verification Sent');
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message!);
    }
  }

  // GOOGLE SIGN IN

  FutureEither<UserCollection> signInWithGoogle(BuildContext context) async {
    try {
      UserCredential userCredential;
      late UserCollection userModel;

      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');

        await _auth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

        final googleAuth = await googleUser?.authentication;

        if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken,
            idToken: googleAuth?.idToken,
          );
          userCredential = await _auth.signInWithCredential(credential);
          final user = userCredential.user!;
          if (userCredential.additionalUserInfo!.isNewUser) {
            userModel = UserCollection(
              id: user.uid,
              cid: cid,
              bid: [],
              email: user.email!,
              name: user.displayName!,
              photoUrl: user.photoURL ?? "",
              notificationsEnabled: "true",
              isAdmin: false,
              isPremiumUser: true,
              recentlyAccessed: [],
            );
            await _supabaseClient.from('userscollection').insert({
              'uid': user.uid,
              'cid': cid,
              'bid': [],
              'email': user.email,
              'name': user.displayName,
              'photoUrl': user.photoURL ?? "",
              'notificationsEnabled': "true",
              'isAdmin': false,
              'isPremiumUser': true,
              'recentlyAccessed': [],
            });
          } else {
            userModel = await getUserData(userCredential.user!.uid).first;
          }
        }
      }
      return right(userModel);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // Change Password
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      User? user = _auth.currentUser;
      AuthCredential credential = EmailAuthProvider.credential(
          email: user!.email!, password: oldPassword);
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
      Utils.showSnackBar('Password Changed Successfully');
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message!);
    }
  }

  // SIGN OUT
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      Routemaster.of(context).push('/');
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message!); // Displaying the error message
    }
  }

  // DELETE ACCOUNT
  Future<void> deleteAccount(BuildContext context) async {
    try {
      deleteUser(user.uid);
      await _auth.currentUser!.delete();
      Routemaster.of(context).popUntil((routeData) => false);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message!);
      // Displaying the error message
      // if an error of requires-recent-login is thrown, make sure to log
      // in user again and then delete account.
    }
  }

// UPDATE NAME
  Future<void> updateName(BuildContext context, String name, String uid) async {
    try {
      await FirebaseAuth.instance.currentUser!.updateDisplayName(
        name,
      );
      await _supabaseClient.from('userscollection').update({
        'name': name,
      }).eq('uid', uid);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message!); // Displaying the error message
    }
  }

  Future<void> deleteUser(String uid) async {
    await _auth.currentUser!.delete();
    await _supabaseClient.from('userscollection').delete().eq('uid', uid);
  }

  Stream<UserCollection> getUserData(String uid) {
    Stream<UserCollection> user;
    user = _supabaseClient
        .from('userscollection')
        .stream(primaryKey: ['uid'])
        .eq('uid', uid)
        .map((event) {
          return UserCollection(
              id: event.elementAt(0)['uid'],
              bid: event.elementAt(0)['bid'],
              cid: event.elementAt(0)['cid'],
              notificationsEnabled: event.elementAt(0)['notificationsEnabled'],
              email: event.elementAt(0)['email'],
              name: event.elementAt(0)['name'],
              photoUrl: event.elementAt(0)['photoUrl'],
              isAdmin: event.elementAt(0)['isAdmin'],
              isPremiumUser: event.elementAt(0)['isPremiumUser'],
              recentlyAccessed: event.elementAt(0)['recentlyAccessed']);
        });
    return user;
  }
}
