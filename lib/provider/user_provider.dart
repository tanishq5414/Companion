import 'package:flutter/widgets.dart';
import 'package:notesapp/provider/firebase_auth_methods.dart';

import '../domain/user_modal.dart';

class UserProvider with ChangeNotifier {
  UserCollection? _user;
  final FirebaseAuthMethods _authMethods = FirebaseAuthMethods();
  Future<void> refreshUser() async {
    UserCollection user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
  UserCollection get getUser => _user??const UserCollection(id: '', name: [], email: '', cid: [], bid: [], notificationsEnabled: '', photoUrl: []);
}
