import 'package:companion/apis/auth_api.dart';
import 'package:companion/apis/user_api.dart';
import 'package:companion/constants/user_constants.dart';
import 'package:companion/core/core.dart';
import 'package:companion/features/auth/views/login_view.dart';
import 'package:companion/features/home/views/nav_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
      authAPI: ref.watch(authAPIProvider),
      userAPI: ref.watch(userAPIProvider),
      ref: ref);
});
final authStateProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});
final curentUserAccountProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

class AuthController extends StateNotifier<bool> {
  final Ref _ref;
  final AuthAPI _authAPI;
  final UserAPI _userAPI;
  AuthController(
      {required AuthAPI authAPI, required UserAPI userAPI, required Ref ref})
      : _authAPI = authAPI,
        _userAPI = userAPI,
        _ref = ref,
        super(false);

  Stream<User?> get authStateChange => _authAPI.authStateChange;
  void signInWithGoogle(BuildContext context) async {
    state = true;
    final user = await _authAPI.signInWithGoogle(context);
    state = false;
    user.fold((l) => showSnackBar(context, l.message), (userCredential) async {

      if (userCredential.additionalUserInfo!.isNewUser) {
        _userAPI.saveUserData(
          uid: userCredential.user!.uid,
          email: userCredential.user!.email!,
          name: userCredential.user!.displayName ?? UserConstants.userName,
          photoUrl: userCredential.user!.photoURL ?? UserConstants.userPhotoUrl,
        );
      } else {
        _userAPI.getUserData(userCredential.user!.uid);
      }
      Navigator.push(context, NavView.route(token: userCredential.user!));
    });
  }

  void signOut(context) async {
    await _authAPI.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        LoginView.route(),
        (route) => false,
      );
  }
}
