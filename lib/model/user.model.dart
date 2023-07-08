// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String? uid;
  String? email;
  String? name;
  bool? notificationsEnabled;
  List<String>? bid;
  List<String>? cid;
  String? photoUrl;
  bool? isAdmin;
  bool? isPremiumUser;
  List<String>? recentlyAccessed;
  List<String>? followers;
  List<String>? following;
  int? notesContributed;
  int? coursesContributed;
  List<String>? coursesContributedList;
  List<String>? notesContributedList;

  UserModel(
      {this.uid,
      this.email,
      this.name,
      this.notificationsEnabled,
      this.bid,
      this.cid,
      this.photoUrl,
      this.isAdmin,
      this.isPremiumUser,
      this.recentlyAccessed,
      this.followers,
      this.following,
      this.notesContributed,
      this.coursesContributed,
      this.coursesContributedList,
      this.notesContributedList});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    name = json['name'];
    notificationsEnabled = json['notificationsEnabled'];
    bid = json['bid'].cast<String>();
    cid = json['cid'].cast<String>();
    photoUrl = json['photoUrl'];
    isAdmin = json['isAdmin'];
    isPremiumUser = json['isPremiumUser'];
    recentlyAccessed = json['recentlyAccessed'].cast<String>();
    followers = json['followers'].cast<String>();
    following = json['following'].cast<String>();
    notesContributed = json['notesContributed'];
    coursesContributed = json['coursesContributed'];
    coursesContributedList = json['coursesContributedList'].cast<String>();
    notesContributedList = json['notesContributedList'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['email'] = this.email;
    data['name'] = this.name;
    data['notificationsEnabled'] = this.notificationsEnabled;
    data['bid'] = this.bid;
    data['cid'] = this.cid;
    data['photoUrl'] = this.photoUrl;
    data['isAdmin'] = this.isAdmin;
    data['isPremiumUser'] = this.isPremiumUser;
    data['recentlyAccessed'] = this.recentlyAccessed;
    data['followers'] = this.followers;
    data['following'] = this.following;
    data['notesContributed'] = this.notesContributed;
    data['coursesContributed'] = this.coursesContributed;
    data['coursesContributedList'] = this.coursesContributedList;
    data['notesContributedList'] = this.notesContributedList;
    return data;
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? name,
    bool? notificationsEnabled,
    List<String>? bid,
    List<String>? cid,
    String? photoUrl,
    bool? isAdmin,
    bool? isPremiumUser,
    List<String>? recentlyAccessed,
    List<String>? followers,
    List<String>? following,
    int? notesContributed,
    int? coursesContributed,
    List<String>? coursesContributedList,
    List<String>? notesContributedList,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      bid: bid ?? this.bid,
      cid: cid ?? this.cid,
      photoUrl: photoUrl ?? this.photoUrl,
      isAdmin: isAdmin ?? this.isAdmin,
      isPremiumUser: isPremiumUser ?? this.isPremiumUser,
      recentlyAccessed: recentlyAccessed ?? this.recentlyAccessed,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      notesContributed: notesContributed ?? this.notesContributed,
      coursesContributed: coursesContributed ?? this.coursesContributed,
      coursesContributedList:
          coursesContributedList ?? this.coursesContributedList,
      notesContributedList: notesContributedList ?? this.notesContributedList,
    );
  }
}
