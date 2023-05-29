import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companion/core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final chatAPIProvider = Provider<ChatAPI>((ref) {
  final firestore = ref.watch(fireStoreProvider);
  final auth = ref.watch(authProvider);
  return ChatAPI(firestore: firestore, auth: auth);
});

abstract class IChatAPI {
  FutureVoid sendMessage(String message);
  Stream getMessages();
}

class ChatAPI {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  ChatAPI({required FirebaseFirestore firestore, required FirebaseAuth auth})
      : _firestore = firestore,
        _auth = auth;

  FutureVoid sendTextMessage(String message) async {
    final user = _auth.currentUser;
    if (user != null) {
      final docRef = _firestore.collection('messages').doc();
      final messageId = docRef.id;
      await docRef.set({
        'message': message,
        'sender': user.uid,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'messageid': messageId,
        'senderName': user.displayName,
        'senderPhotoUrl': user.photoURL,
      });
    }
  }

  Stream getMessages() {
    return _firestore.collection('messages').orderBy('timestamp', descending: false).limitToLast(20).snapshots();
  }
}
