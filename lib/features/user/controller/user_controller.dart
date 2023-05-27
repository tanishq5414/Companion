import 'package:companion/apis/auth_api.dart';
import 'package:companion/apis/user_api.dart';
import 'package:companion/core/core.dart';
import 'package:companion/modal/user.modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDataProvider = StateProvider<UserModal?>((ref) => null);
final timeTableUrlProvider = StateProvider<String?>((ref) => null);
final userControllerProvider =
    StateNotifierProvider<UserController, bool>((ref) {
  return UserController(
      authAPI: ref.watch(authAPIProvider),
      userAPI: ref.watch(userAPIProvider),
      ref: ref);
});

class UserController extends StateNotifier<bool> {
  final UserAPI _userAPI;
  final AuthAPI _authAPI;
  final Ref _ref;
  UserController(
      {required AuthAPI authAPI, required UserAPI userAPI, required Ref ref})
      : _userAPI = userAPI,
        _authAPI = authAPI,
        _ref = ref,
        super(false);

  FutureVoid saveUserData({
    required BuildContext context,
    required String uid,
    required String name,
    required String email,
    required String rno,
    required String branch,
    required int semester,
    required int year,
    required String phone,
    required String section,
    required String photoUrl,
  }) async {
    state = true;
    await _userAPI.saveUserData(
      uid: uid,
      name: name,
      email: email,
      photoUrl: photoUrl,
    );
    getUserData(context: context, uid: uid);
    state = false;
  }

  FutureVoid getUserData({
    required BuildContext context,
    required String uid,
  }) async {
    var res = await _userAPI.getUserData(uid).first;
    _ref.read(userDataProvider.notifier).update((state) => res);
  }

  void updateName(BuildContext context, fullName, uid) {
    state = true;
    _userAPI.updateName(uid, fullName);
    _ref.read(userDataProvider.notifier).update((state) => state!.copyWith(
          name: fullName,
        ));
    state = false;
  }

  void bookmarkNotes(BuildContext context, String notesId) {
    var user = _ref.read(userDataProvider)!;
    var bookmarks = user.bid!;
    if (bookmarks.contains(notesId)) {
      bookmarks.remove(notesId);
    } else {
      bookmarks.add(notesId);
    }
    bookmarks = bookmarks.toSet().toList();
    _userAPI.updateBookmarks(user.uid!, bookmarks);
    _ref.read(userDataProvider.notifier).update((state) => state!.copyWith(
          bid: bookmarks,
        ));
    state = false;
  }

  void updateUserCourses(BuildContext context, String uid, var cid) {
    _userAPI.updateUserCourses(uid, cid);
    _ref.read(userDataProvider.notifier).update((state) => state!.copyWith(
          cid: cid,
        ));
  }

  void updateContributed(
    BuildContext context,
    String notesid,
    String courseName,
  ) {
    final user = _ref.watch(userDataProvider)!;
    var notesidList = user.notesContributedList! + [notesid];
    var courseNameList = user.coursesContributedList! + [courseName];
    var notesContributed = user.notesContributed! + 1;
    var coursesContributed = user.coursesContributed! + 1;
    _userAPI.updateContributed(
        user.uid!,
        notesidList, courseNameList, notesContributed, coursesContributed);
    _ref.read(userDataProvider.notifier).update((state) => state!.copyWith(
          notesContributedList: notesidList,
          coursesContributedList: courseNameList,
          notesContributed: notesContributed,
          coursesContributed: coursesContributed,
        ));
  }
}
