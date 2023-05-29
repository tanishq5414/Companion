import 'package:companion/common/loading_page.dart';
import 'package:companion/features/chat/controller/chat_controller.dart';
import 'package:companion/features/chat/widgets/message_tile.dart';
import 'package:companion/features/user/controller/user_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatList extends ConsumerStatefulWidget {
  final String recieverUserId;
  final bool isGroupChat;
  const ChatList({
    Key? key,
    required this.recieverUserId,
    required this.isGroupChat,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final ScrollController messageController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final user = ref.watch(userDataProvider)!;
    return StreamBuilder(
        stream: ref.read(chatControllerProvider.notifier).getMessages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }

          SchedulerBinding.instance.addPostFrameCallback((_) {
            messageController
                .jumpTo(messageController.position.maxScrollExtent);
          });

          return ListView.builder(
              controller: messageController,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> chatMap =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                DateTime date =
                    DateTime.fromMillisecondsSinceEpoch(chatMap['timestamp']);
                return InkWell(
                  onLongPress: (){
                    if(!user.isAdmin!){
                      return;
                    }
                    // delete option 
                    //show a dialog box
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        title: const Text('Delete Message'),
                        content: const Text('Are you sure you want to delete this message?'),
                        actions: [
                          TextButton(onPressed: (){
                            Navigator.pop(context);
                          }, child: const Text('No')),
                          TextButton(onPressed: (){
                            Navigator.pop(context);
                            ref.read(chatControllerProvider.notifier).deleteMessage(chatMap['messageid']);
                          }, child: const Text('Yes')),
                        ],
                      );
                    });
                  },
                  child: MessageTile(size, chatMap, date));
              });
        });
  }
}
