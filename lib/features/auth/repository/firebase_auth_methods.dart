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
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/otp_box.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firestore: ref.read(firestoreProvider),
    auth: ref.read(authProvider),
    googleSignIn: ref.read(googleSignInProvider),
  ),
);

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn;

  CollectionReference get _users => _firestore.collection('users');
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
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      user?.updateDisplayName(fullName);
      List bid = [];
      await sendEmailVerification(context);
      UserCollection usertemp = UserCollection(
        id: user!.uid,
        cid: cid,
        bid: bid,
        email: user.email!,
        name: user.displayName!,
        photoUrl: user.photoURL!,
        notificationsEnabled: "true",
      );
      await _firestore.collection('users').doc(user.uid).set(usertemp.toMap());
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
      await _firestore.collection('users').doc(uid).update({
        'cid': cid,
      });
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
  // Bookmark Notes
  Future<String> bookmarkNotes(String id, String gid, bookmarks) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var bid = prefs.getStringList('bid')??[];
    String res = "Some error occurred";
    try {
      // print(bookmarks);
      // L bookmarks = await _firestore.collection('users').doc(id).collection('bookmarks').get();
      if (bookmarks.contains(gid)) {
        // print(gid);
        // print('tanishq');
        // print(34);
        // if the likes list contains the user uid, we need to remove it
        _firestore.collection('users').doc(id).update({
          'bid': FieldValue.arrayRemove([gid])
        });
        bid.remove(gid);
        prefs.setStringList('bid', bid);
      } else {
        // else we need to add uid to the likes array
        _firestore.collection('users').doc(id).update({
          'bid': FieldValue.arrayUnion([gid])
        });
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
    // late UserCollection userCollection;
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
              photoUrl: user.photoURL!,
              notificationsEnabled: "true",
            );
            await _firestore
                .collection('users')
                .doc(userModel.id)
                .set(userModel.toMap());
          } else {
            userModel = await getUserData(userCredential.user!.uid).first;
          }
        }
      }
      return right(userModel);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      print(e);
      return left(Failure(e.toString()));
    }
  }

  // // FACEBOOK SIGN IN
  Future<void> signInWithFacebook(BuildContext context) async {
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
          // ignore: use_build_context_synchronously
          await sendEmailVerification(context);
          UserCollection _user = UserCollection(
            id: user.uid,
            cid: cid,
            bid: bid,
            email: user.email!,
            name: user.displayName!,
            photoUrl: user.photoURL!,
            notificationsEnabled: "true",
          );
          await _firestore.collection('users').doc(user.uid).set(_user.toMap());
        }
      }
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message!); // Displaying the error message
    }
  }

  // PHONE SIGN IN
  Future<void> phoneSignIn(
    BuildContext context,
    String phoneNumber,
  ) async {
    TextEditingController codeController = TextEditingController();
    if (kIsWeb) {
      // !!! Works only on web !!!
      ConfirmationResult result =
          await _auth.signInWithPhoneNumber(phoneNumber);

      // Diplay Dialog Box To accept OTP
      showOTPDialog(
        codeController: codeController,
        context: context,
        onPressed: () async {
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: result.verificationId,
            smsCode: codeController.text.trim(),
          );

          await _auth.signInWithCredential(credential);
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop(); // Remove the dialog box
          // ignore: use_build_context_synchronously
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        },
      );
    } else {
      // FOR ANDROID, IOS
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        //  Automatic handling of the SMS code
        verificationCompleted: (PhoneAuthCredential credential) async {
          // !!! works only on android !!!
          await _auth.signInWithCredential(credential);
        },
        // Displays a message when verification fails
        verificationFailed: (e) {
          Utils.showSnackBar(e.message!);
        },
        // Displays a dialog box when OTP is sent
        codeSent: ((String verificationId, int? resendToken) async {
          showOTPDialog(
            codeController: codeController,
            context: context,
            onPressed: () async {
              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                verificationId: verificationId,
                smsCode: codeController.text.trim(),
              );

              // !!! Works only on Android, iOS !!!
              await _auth.signInWithCredential(credential);
              UserCredential userCredential =
                  await _auth.signInWithCredential(credential);
              final user = userCredential.user!;
              if (userCredential.user != null) {
                if (userCredential.additionalUserInfo!.isNewUser) {
                  List bid = [];
                  // ignore: use_build_context_synchronously
                  await sendEmailVerification(context);
                  UserCollection _user = UserCollection(
                    id: user.uid,
                    cid: cid,
                    bid: bid,
                    email: user.email!,
                    name: user.displayName!,
                    photoUrl: user.photoURL!,
                    notificationsEnabled: "true",
                  );
                  await _firestore
                      .collection('users')
                      .doc(user.uid)
                      .set(_user.toMap());
                }
              }
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
              // ignore: use_build_context_synchronously
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (route) => false); // Remove the dialog box
            },
          );
        }),
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-resolution timed out...
        },
      );
    }
  }

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
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(context, '/start', (route) => false);
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
      _firestore.collection('users').doc(uid).update({
        'name': name,
      });
      print(5);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message!); // Displaying the error message
    }
  }

// UPDATE EMAIL
  Future<void> updateEmail(
      BuildContext context, String newemail, String password) async {
    var email = FirebaseAuth.instance.currentUser!.email.toString();
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.toString(), password: password.toString());
    try {
      await FirebaseAuth.instance.currentUser!.updateEmail(
        newemail,
      );
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      Utils.showSnackBar(
          'Email updated successfully. Please verify your new email.');
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message!); // Displaying the error message
    }
  }

  Future<void> deleteUser(String uid) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).delete();
    print('user deleted');
  }

  Stream<UserCollection> getUserData(String uid) {
    return _users.doc(uid).snapshots().map((event) =>
        UserCollection.fromMap(event.data() as Map<String, dynamic>));
  }
}
