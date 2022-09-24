import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/pages/components/snack_bar.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../pages/components/otp_box.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  // FOR EVERY FUNCTION HERE
  // POP THE ROUTE USING: Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);

  // GET USER DATA
  // using null check operator since this method should be called only
  // when the user is logged in
  User get user => _auth.currentUser!;

  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

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
      User? user1 = result.user;
      user1?.updateDisplayName(fullName);
      // ignore: use_build_context_synchronously
      await sendEmailVerification(context);
    } on FirebaseAuthException catch (e) {
      // if you want to display your own custom error message
      if (e.code == 'weak-password') {
        Utils.showSnackBar('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Utils.showSnackBar('The account already exists for that email.');
      }
      Utils.showSnackBar(
          e.message!); // Displaying the usual firebase error message
    }
  }

  // EMAIL LOGIN
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!user.emailVerified) {
        // ignore: use_build_context_synchronously
        await sendEmailVerification(context);
        // restrict access to certain things using provider
        // transition to another page instead of home screen
      }
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message!); // Displaying the error message
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
      Utils.showSnackBar(e.message!); // Displaying the error message
    }
  }

  // EMAIL VERIFICATION
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      Utils.showSnackBar('Email Verification Sent');
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message!); // Display error message
    }
  }

  // GOOGLE SIGN IN
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');

        await _auth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
          // Create a new credential
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken,
            idToken: googleAuth?.idToken,
          );
          // ignore: unused_local_variable
          UserCredential userCredential =
              await _auth.signInWithCredential(credential);

          // if (userCredential.user != null) {
          //   if (userCredential.additionalUserInfo!.isNewUser) {}
          // }
        }
      }
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message!); // Displaying the error message
    }
  }
  
  // // FACEBOOK SIGN IN
  Future<void> signInWithFacebook(BuildContext context) async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      await _auth.signInWithCredential(facebookAuthCredential);
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
      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message!); // Displaying the error message
      // if an error of requires-recent-login is thrown, make sure to log
      // in user again and then delete account.
    }
  }
}
