import 'package:companion/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotifDisplay extends ConsumerStatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => NotifDisplay());
  }

  const NotifDisplay({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotifDisplayState();
}

class _NotifDisplayState extends ConsumerState<NotifDisplay> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final margin = EdgeInsets.symmetric(
      horizontal: size.width * 0.05,
      vertical: size.height * 0.02,
    );
    final listheight = size.height * 0.15;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Notifications',
      ),
      body: Container(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              height: listheight,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 64, 66, 67),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: margin,
              child: ListTile(
                textColor: Colors.white,
                title: Text('Notification'),
                subtitle: Text('This is a notification'),
                trailing: Text("data"),
              ),
            );
          },
        ),
      ),
    );
  }
}
