import 'package:companion/core/core.dart';
import 'package:companion/model/user.model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

final userAPIProvider = Provider((ref) {
  return UserAPI(
    supabaseClient: ref.watch(userProvider),
  );
});

final dio = Dio();

abstract class IUserAPI {
  FutureVoid saveUserData(
      {required uid, required email, required name, required photoUrl});
  Stream<UserModel> getUserData(String uid);
  FutureVoid deleteUser(String uid);
  FutureVoid updateName(String uid, String name);
  FutureVoid updateBookmarks(String uid, List<String> bookmarks);
  FutureVoid updateUserCourses(String uid, List<String> courseid);
  FutureVoid updateContributed(
      String uid,
      List<String> notesidList,
      List<String> courseNameList,
      int notesContributed,
      int coureseContributed);
}

class UserAPI implements IUserAPI {
  final supabase.SupabaseClient _supabaseClient;
  UserAPI({required supabase.SupabaseClient supabaseClient})
      : _supabaseClient = supabaseClient;

  @override
  Stream<UserModel> getUserData(String uid) {
    Stream<UserModel> user;
    user = _supabaseClient
        .from('userscollection')
        .stream(primaryKey: ['uid'])
        .eq('uid', uid)
        .map((event) {
          return UserModel.fromJson(event.first);
        });
    return user;
  }

  @override
  FutureVoid updateName(String uid, String name) async {
    await _supabaseClient.from('userscollection').update({
      'name': name,
    }).eq('uid', uid);
  }

  @override
  FutureVoid saveUserData(
      {required uid, required email, required name, required photoUrl}) async {
    try {
      await _supabaseClient.rpc('insertuserdata', params: {
        'uid': uid,
        'email': email,
        'name': name,
        'photourl': photoUrl,
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  FutureVoid updateBookmarks(String uid, List<String> bookmarks) async {
    await _supabaseClient.from('userscollection').update({
      'bid': bookmarks,
    }).eq('uid', uid);
  }

  @override
  FutureVoid updateUserCourses(String uid, List<String> courseid) async {
    await _supabaseClient.from('userscollection').update({
      'cid': courseid,
    }).eq('uid', uid);
  }

  @override
  FutureVoid updateContributed(
      String uid,
      List<String> notesidList,
      List<String> courseNameList,
      int notesContributed,
      int coureseContributed) async {
    await _supabaseClient.from('userscollection').update({
      'notesContributed': notesContributed,
      'coursesContributed': coureseContributed,
      'notesContributedList': notesidList,
      'coursesContributedList': courseNameList,
    }).eq('uid', uid);
  }
  
  @override
  FutureVoid deleteUser(String uid) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }
}
