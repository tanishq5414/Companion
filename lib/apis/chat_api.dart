import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companion/config/config.dart';
import 'package:companion/core/core.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';


final dio = Dio();
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

  Future<void> sendTextMessage(String message) async {
  final user = _auth.currentUser;
  if (user != null) {
    final docRef = _firestore.collection('messages').doc();
    final messageId = docRef.id;

    // Fetch NSFW word list from API and parse the JSON response
    final nsfwWordList = await fetchNSFWWordList();

    // Check if the message contains any NSFW words
    if (containsNSFWWords(message, nsfwWordList)) {
      print('Message contains NSFW content. Skipping...');
      return;
    }

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
Future<List<String>> fetchNSFWWordList() async {
  final response = await dio.get(wordlistURL);
  final nsfwWordList = response.data.cast<String>();
  return nsfwWordList;
}
bool containsNSFWWords(String message, List<String> nsfwWordList) {
  final lowerCaseMessage = message.toLowerCase();
  for (final word in nsfwWordList) {
    if (lowerCaseMessage.contains(word.toLowerCase())) {
      return true;
    }
  }
  return false;
}

  Stream getMessages() {
    return _firestore.collection('messages').orderBy('timestamp', descending: false).limitToLast(40).snapshots();
  }

  // delete message accoring to message id
  FutureVoid deleteMessage(String messageId) async {
    await _firestore.collection('messages').doc(messageId).delete();
  }
}
