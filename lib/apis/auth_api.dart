import 'package:companion/core/core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Authentication library
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpod dependency injection
import 'package:fpdart/fpdart.dart'; // fpdart functional programming library
import 'package:google_sign_in/google_sign_in.dart'; // Google Sign-In library
// Application-specific code

/// Riverpod provider for the authentication API.
final authAPIProvider = Provider((ref) {
  final account = ref.watch(
      authProvider); // Get the Firebase Authentication instance from another provider
  return AuthAPI(
    auth:
        account,// Pass the Firebase Authentication instance to the AuthAPI constructor
  );
});

/// Interface for the authentication API.
abstract class IAuthAPI {
  /// A method to sign in with Google.
  FutureEither<UserCredential> signInWithGoogle(BuildContext context);

  /// A method to sign out.
  FutureVoid signOut();

  /// A method to update the user's name.
  void updateName(fullName);
}

/// Concrete implementation of the authentication API.
class AuthAPI implements IAuthAPI {
  final FirebaseAuth
      _auth; // Private instance of the Firebase Authentication service.
  /// Constructor that initializes the private [_auth] field.
  AuthAPI({required FirebaseAuth auth}) : _auth = auth;

  /// A getter to get a stream of changes to the authentication state.
  Stream<User?> get authStateChange => _auth.authStateChanges();

  @override

  /// Use the Google Sign-In library to sign in with Google.
  /// Returns a Right with the [UserCredential] if successful, or a Left with a [Failure] object if unsuccessful.
  FutureEither<UserCredential> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn().signIn(); // Get a GoogleSignInAccount

      final GoogleSignInAuthentication? googleAuth = await googleUser
          ?.authentication; // Get the Google authentication tokens

      // If both the access token and ID token are not null, create a GoogleAuthProvider credential and sign in to Firebase Authentication.
      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        return right(userCredential); // Return a Right with the UserCredential
      } else {
        return left(Failure(
            'Google Sign In Failed',
            StackTrace
                .empty)); // Return a Left with a Failure object if the sign-in fails
      }
    } on FirebaseAuthException catch (e, st) {
      return left(Failure(e.message ?? e.toString(),
          st)); // Return a Left with a Failure object if there is an authentication error
    }
  }

  @override

  /// Sign out of the Google account and Firebase Authentication.
  FutureVoid signOut() async {
    await GoogleSignIn().signOut();
    // await _ref.read(userDataProvider.notifier).update(state = nulll)
    return await _auth.signOut();
  }

  @override
  void updateName(fullName) async {
    try{
    await _auth.currentUser!.updateDisplayName(fullName);}
    catch(e){
      print(e);
    }
  }
}
