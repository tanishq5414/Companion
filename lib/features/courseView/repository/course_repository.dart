import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notesapp/modal/user_modal.dart';


class CourseRepository{
  final FirebaseFirestore _firestore;
  CourseRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  void bookmarkCourse(UserCollection userCollection, String cid) async {
    
  }
}

