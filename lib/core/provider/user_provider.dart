import 'package:flutter/widgets.dart';
import '../../modal/user_modal.dart';

class UserProvider with ChangeNotifier{
  UserCollection? _user;

  UserCollection get getUser =>
      _user ??
      UserCollection(
          id: '',
          name: '',
          email: '',
          cid: [],
          bid: [],
          notificationsEnabled: '',
          photoUrl: '');
}
