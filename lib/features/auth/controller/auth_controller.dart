import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notesapp/features/auth/repository/firebase_auth_methods.dart';
import 'package:notesapp/modal/user_modal.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/snack_bar.dart';

final userProvider = StateProvider<UserCollection?>((ref) => null);



final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref,
  ),
);
final authStateProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);
  Stream<UserCollection> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  Stream<User?> get authStateChange => _authRepository.authStateChange;
  void signInWithGoogle(BuildContext context) async {
    state = true;
    final user = await _authRepository.signInWithGoogle(context);
    state = false;
    SharedPreferences pref = await SharedPreferences.getInstance();
    user.fold((l) => Utils.showSnackBar(l.message), (userModel) {
      _ref.read(userProvider.notifier).update((state) => userModel);
      pref.setString("email", userModel.email);
    });
  }

  void logInWithEmail(BuildContext context, email, password) async {
    final user = _authRepository.loginWithEmail(
        email: email, password: password, context: context);
  }

  void signUpwithEmail(BuildContext context, email, password, fullName) async {
    final user = _authRepository.signUpWithEmail(
        email: email, password: password, fullName: fullName, context: context);
  }

  void signOut(BuildContext context) async {
    final user = _authRepository.signOut(context);
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("email");
  }

  void updateName(BuildContext context, fullName) async {
    final user = _authRepository.updateName(context, fullName);
  }

  void updateEmail(BuildContext context, newemail, password) {
    final user = _authRepository.updateEmail(context, newemail, password);
  }

  void deleteAccount(BuildContext context) async {
    final user = _authRepository.deleteAccount(context);
  }
}
