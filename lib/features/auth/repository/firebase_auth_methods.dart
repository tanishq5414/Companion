// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:notesapp/core/failure.dart';
import 'package:notesapp/core/provider/firebase_providers.dart';
import 'package:notesapp/core/type_defs.dart';
import 'package:notesapp/modal/user_modal.dart';
import 'package:notesapp/features/components/snack_bar.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    firestore: ref.read(firestoreProvider),
  ),
);

class AuthRepository {
  final supabase.SupabaseClient _supabaseClient;
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  AuthRepository({
    required supabase.SupabaseClient supabaseClient,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
    required FirebaseFirestore firestore,
  })  : _auth = auth,
        _firestore = firestore,
        _supabaseClient = supabaseClient,
        _googleSignIn = googleSignIn;

  User get user => _auth.currentUser!;
  var cid = [];
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
      var user = result.user!;
      final data = await _supabaseClient.from('userscollection').insert({
        "uid": "${user.uid}",
        "cid": [],
        "bid": [],
        "email": "${user.email}",
        "name": "$fullName",
        "notificationsEnabled": "true",
        "photoUrl": "yes"
      });
      print(data);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Utils.showSnackBar('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Utils.showSnackBar('The account already exists for that email.');
      }
      Utils.showSnackBar(e.message!);
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
  Future<String> bookmarkNotes(String id, String gid, bookmarks) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var bid = prefs.getStringList('bid') ?? [];
    getUserData(id);
    String res = "Some error occurred";
    try {
      if (bookmarks.contains(gid)) {
        _supabaseClient.from('userscollection').update({
          'bid': FieldValue.arrayRemove([gid])
        }).eq('uid', id);
        bid.remove(gid);
        prefs.setStringList('bid', bid);
      } else {
        // else we need to add uid to the likes array
        _supabaseClient.from('userscollection').update({
          'bid': FieldValue.arrayUnion([gid])
        }).eq('uid', id);
        bid.add(gid);
        if (kDebugMode) {
          print(bid);
        }
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // EMAIL LOGIN
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    try {
      if (!user.emailVerified) {
        // ignore: use_build_context_synchronously
        await sendEmailVerification(context);
        Utils.showSnackBar(
            'Please verify your email first. Verification link sent to $email');
      }
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message!);
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
            );
            await _supabaseClient.from('userscollection').insert({
              'uid': user.uid,
              'cid': cid,
              'bid': [],
              'email': user.email,
              'name': user.displayName,
              'photoUrl': user.photoURL ?? "",
              'notificationsEnabled': "true",
            });
          } else {
            userModel = await getUserData(userCredential.user!.uid).first;
          }
        }
      }
      return right(userModel);
    } catch (e) {
      print(e);
      return left(Failure(e.toString()));
    }
  }

  FutureEither<UserCollection> signInWithFacebook(BuildContext context) async {
      late UserCollection userModel;
    try { 

        final LoginResult loginResult = await FacebookAuth.instance.login();
        final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      await _auth.signInWithCredential(facebookAuthCredential);
      UserCredential userCredential =
          await _auth.signInWithCredential(facebookAuthCredential);
      final user = userCredential.user!;
      if (userCredential.user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {

          List bid = [];
          await sendEmailVerification(context);
          userModel = UserCollection(
              id: user.uid,
              cid: cid,
              bid: [],
              email: user.email!,
              name: user.displayName!,
              photoUrl: user.photoURL ?? "",
              notificationsEnabled: "true",
            );
          await _supabaseClient.from('userscollection').insert({
            'uid': user.uid,
            'cid': cid,
            'bid': [],
            'email': user.email,
            'name': user.displayName,
            'photoUrl': user.photoURL ?? "",
            'notificationsEnabled': "true",
          });
        }
      }else {
            userModel = await getUserData(userCredential.user!.uid).first;
          }
      return right(userModel);
        }catch (e) {
      return left(Failure(e.toString()));
    }
}

  // // // FACEBOOK SIGN IN
  // FutureEither<UserCollection> signInWithFacebook(BuildContext context) async {
  //   try {
      // final LoginResult loginResult = await FacebookAuth.instance.login();
      // final OAuthCredential facebookAuthCredential =
      //     FacebookAuthProvider.credential(loginResult.accessToken!.token);
      // await _auth.signInWithCredential(facebookAuthCredential);
      // UserCredential userCredential =
      //     await _auth.signInWithCredential(facebookAuthCredential);
      // final user = userCredential.user!;
      // if (userCredential.user != null) {
      //   if (userCredential.additionalUserInfo!.isNewUser) {
      //     List bid = [];
      //     await sendEmailVerification(context);
      //     await _supabaseClient.from('userscollection').insert({
      //       'uid': user.uid,
      //       'cid': cid,
      //       'bid': [],
      //       'email': user.email,
      //       'name': user.displayName,
      //       'photoUrl': user.photoURL ?? "",
      //       'notificationsEnabled': "true",
      //     });
      //   }
      // }
  //   } on FirebaseAuthException catch (e) {
  //     Utils.showSnackBar(e.message!); // Displaying the error message
  //   }
  // }

  // SIGN OUT
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message!); // Displaying the error message
    }
  }

  // DELETE ACCOUNT
  Future<void> deleteAccount(BuildContext context) async {
    try {
      deleteUser(user.uid);
      await _auth.currentUser!.delete();
      Routemaster.of(context).push('/');
      print('user deleted');
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
      print(4);
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
    print('user deleted');
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
              photoUrl: event.elementAt(0)['photoUrl']);
        });
    return user;
  }
}
