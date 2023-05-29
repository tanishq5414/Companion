import 'package:companion/features/chat/widgets/bottom_chat_field.dart';
import 'package:companion/features/chat/widgets/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MobileChatScreen extends ConsumerWidget {

  static Route route(String uid) {
    return MaterialPageRoute<void>(builder: (_) => MobileChatScreen(uid: uid));
  }
  final String uid;
  const MobileChatScreen({
    Key? key,
    required this.uid,
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('#communitychat'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ChatList(
                recieverUserId: uid,
                isGroupChat: true,
              ),
            ),
            BottomChatField(
              recieverUserId: uid,
              isGroupChat: true,
            ),
          ],
        ),
      ),
    );
  }
}
