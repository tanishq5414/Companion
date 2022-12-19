import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
  Future<String> bookmarkNotes(String id, String gid, bookmarks) async {
    String res = "Some error occurred";
    // print(_userCollection);
    try {
      // L bookmarks = await _firestore.collection('users').doc(id).collection('bookmarks').get();
      if (bookmarks.contains(gid)) {
        // if the likes list contains the user uid, we need to remove it
        _firestore.collection('users').doc(id).update({
          'bid': FieldValue.arrayRemove([gid])
        });
      } else {
        // else we need to add uid to the likes array
        _firestore.collection('users').doc(id).update({
          'bid': FieldValue.arrayUnion([gid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> updateUserCourses(String uid, List cid) async {
    String res = "Some error occurred";
    try {
      await _userCollection.doc(uid).update({
        'cid': cid,
      });
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
