import 'package:cloud_firestore/cloud_firestore.dart';

class UserCollection {
  final String id;
  final List bid;
  final List cid;
  final String notificationsEnabled;
  final String email;
  final List photoUrl;
  final List name;

  const UserCollection(
      {required this.id,
      required this.bid,
      required this.cid,
      required this.notificationsEnabled,
      required this.email,
      required this.photoUrl,
      required this.name});


  static UserCollection fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserCollection(
      id: snapshot["id"],
      cid: snapshot["cid"],
      email: snapshot["email"],
      photoUrl: snapshot["photoUrl"],
      name: snapshot["name"],
      bid: snapshot["bid"],
      notificationsEnabled: snapshot["notificationsEnabled"],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'cid': cid,
        'email': email,
        'photoUrl': photoUrl,
        'name': name,
        'bid': bid,
        'notificationsEnabled': notificationsEnabled,
      };
}
