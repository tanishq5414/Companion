// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';

class UserCollection {
  final String id;
  final List bid;
  final List cid;
  final String notificationsEnabled;
  final String email;
  final String photoUrl;
  final String name;
  UserCollection({
    required this.id,
    required this.bid,
    required this.cid,
    required this.notificationsEnabled,
    required this.email,
    required this.photoUrl,
    required this.name,
  }); 
  UserCollection copyWith({
    String? id,
    List? bid,
    List? cid,
    String? notificationsEnabled,
    String? email,
    String? photoUrl,
    String? name,
  }) {
    return UserCollection(
      id: id ?? this.id,
      bid: bid ?? this.bid,
      cid: cid ?? this.cid,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'bid': bid,
      'cid': cid,
      'notificationsEnabled': notificationsEnabled,
      'email': email,
      'photoUrl': photoUrl,
      'name': name,
    };
  }

  factory UserCollection.fromMap(Map<String, dynamic> map) {
    return UserCollection(
      id: map['id'] as String,
      bid: List.from(map['bid'] as List),
      cid: List.from(map['cid'] as List),
      notificationsEnabled: map['notificationsEnabled'] as String,
      email: map['email'] as String,
      photoUrl: map['photoUrl'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserCollection.fromJson(String source) =>
      UserCollection.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserCollection(id: $id, bid: $bid, cid: $cid, notificationsEnabled: $notificationsEnabled, email: $email, photoUrl: $photoUrl, name: $name)';
  }

  @override
  bool operator ==(covariant UserCollection other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        listEquals(other.bid, bid) &&
        listEquals(other.cid, cid) &&
        other.notificationsEnabled == notificationsEnabled &&
        other.email == email &&
        other.photoUrl == photoUrl &&
        other.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        bid.hashCode ^
        cid.hashCode ^
        notificationsEnabled.hashCode ^
        email.hashCode ^
        photoUrl.hashCode ^
        name.hashCode;
  }
}
