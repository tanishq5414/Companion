// ignore_for_file: unused_import, unused_local_variable

import 'package:companion_rebuild/features/auth/repository/firebase_auth_methods.dart';
import 'package:companion_rebuild/modal/user_modal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
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
  Stream getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  Stream<User?> get authStateChange => _authRepository.authStateChange;
  void signInWithGoogle(BuildContext context) async {
    state = true;
    final user = await _authRepository.signInWithGoogle(context);
    state = false;
    user.fold((l) => Utils.showSnackBar(l.message), (userModel) {
      _ref.read(userProvider.notifier).update((state) => userModel);
    });
  }

  void bookmarkNotes(BuildContext context, String id, bookmarks) {
    final user = _authRepository.bookmarkNotes(id, bookmarks);
  }

  void updateUserCourses(BuildContext context, String uid, var cid) {
    final user = _authRepository.updateUserCourses(uid, cid);
  }

  void incrementNotesOpened(BuildContext context, String uid, String notesid,
      String notesname, String course, String unit) {
    final user = _authRepository.incrementnotesopened(
        uid, notesid, notesname, course, unit);
    var a = _ref.read(userProvider.notifier).state;
    a!.recentlyAccessed.add(notesid);
    _ref.read(userProvider.notifier).update((state) => a);
  }

  void logInWithEmail(BuildContext context, String email, String password,
      WidgetRef ref) async {
    print(1);
    state = true;
    final user = await _authRepository.loginWithEmail(
        email: email, password: password, context: context, ref: ref);
    user.fold((l) => Utils.showSnackBar(l.message),
        (r) => _ref.read(userProvider.notifier).update((state) => r));
    state = false;
  }

  void changePassword(
      BuildContext context, String newpassword, String oldpassword) async {
    state = true;
    final user = _authRepository.changePassword(
      oldPassword: oldpassword,
      newPassword: newpassword,
    );
    state = false;
  }

  void sendEmailVerification(BuildContext context) async {
    state = true;
    final user = _authRepository.sendEmailVerification(context);
    state = false;
  }

  void signUpwithEmail(BuildContext context, email, password, fullName) async {
    state = true;
    final user = _authRepository.signUpWithEmail(
        email: email, password: password, fullName: fullName, context: context);
    state = false;
  }

  void signOut(BuildContext context) async {
    state = true;
    final user = await _authRepository.signOut(
      context,
    );
    _ref.read(userProvider.notifier).state = null;
    state = false;
  }

  void updateName(BuildContext context, fullName, uid) async {
    final user = _authRepository.updateName(context, fullName, uid);
  }

  void deleteAccount(BuildContext context) async {
    state = true;
    final user = await _authRepository.deleteAccount(context);
    _ref.read(userProvider.notifier).state = null;
    state = false;
  }

  void resetPassword(BuildContext context, email) async {
    final user = _authRepository.resetPassword(email: email);
  }
}
