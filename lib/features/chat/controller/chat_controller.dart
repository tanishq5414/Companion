import 'package:companion/apis/auth_api.dart';
import 'package:companion/apis/chat_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatControllerProvider =
    StateNotifierProvider<ChatController, bool>((ref) {
  return ChatController(
      authAPI: ref.watch(authAPIProvider),
      chatAPI: ref.watch(chatAPIProvider),
      ref: ref);
});

class ChatController extends StateNotifier<bool> {
  final Ref _ref;
  final AuthAPI _authAPI;
  final ChatAPI _chatAPI;
  ChatController(
      {required AuthAPI authAPI, required ChatAPI chatAPI, required Ref ref})
      : _authAPI = authAPI,
        _chatAPI = chatAPI,
        _ref = ref,
        super(false);

  void sendTextMessage(
    BuildContext context,
    String text,
  ) {
    _chatAPI.sendTextMessage(text);
  }

  Stream getMessages() {
    return _chatAPI.getMessages();
  }
}
