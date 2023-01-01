import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notesapp/core/provider/notes_provider.dart';
import 'package:notesapp/features/auth/controller/auth_controller.dart';
import 'package:notesapp/modal/notes_modal.dart';
import 'package:routemaster/routemaster.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../theme/colors.dart';

/// Represents Homepage for Navigation
class NotesViewPage extends ConsumerStatefulWidget {
  const NotesViewPage({super.key});

  @override
  ConsumerState<NotesViewPage> createState() => _NotesViewPageState();
}

class _NotesViewPageState extends ConsumerState<NotesViewPage> {
  late var flag = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final notes = RouteData.of(context).queryParameters;
      final user = ref.read(userProvider);
      if (user!.bid.contains(notes['id'])) {
        flag = true;
      }
      // TODO: implement initState
      super.initState();
    });
  }
  

  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider)!;
    final size = MediaQuery.of(context).size;
    final notes = RouteData.of(context).queryParameters;

    void addbookmark() {
      setState(() {
        ref
            .read(authControllerProvider.notifier)
            .bookmarkNotes(context, user.id, notes['id']!, user.bid);
        flag = !flag;
      });
    }

    // void removebookmark() {
    //   setState(() {
    //     ref
    //         .read(authControllerProvider.notifier)
    //         .bookmarkNotes(context, user.id, notes['id']!, user.bid);
    //     flag = false;
    //   });
    // }

    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        backgroundColor: appBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: appWhiteColor),
          onPressed: () {
            Routemaster.of(context).pop();
          },
        ),
        title: Text(
          notes['name']!,
          style: const TextStyle(color: appWhiteColor),
        ),
        actions: [
          flag == false
              ? IconButton(
                  icon: const Icon(Icons.bookmark_border),
                  onPressed: () {
                    print("{$flag} ${user.bid}");
                    addbookmark();
                  })
              : IconButton(
                  icon: const Icon(Icons.bookmark),
                  onPressed: () {
                    print("{$flag} ${user.bid}");
                    addbookmark();
                  },
                ),
          const SizedBox(
            width: 10,
          ),
        ],
        centerTitle: false,
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(size.width * 0.1),
        //   child: Padding(
        //     padding: EdgeInsets.all(size.width * 0.03),
        //     child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Text(notes['unit']!,
        //               style: const TextStyle(
        //                   fontSize: 10,
        //                   fontWeight: FontWeight.bold,
        //                   color: appWhiteColor)),
        //           SizedBox(
        //             height: size.height * 0.005,
        //           ),
        //           Text(notes['course']!,
        //               style: const TextStyle(
        //                   fontSize: 14,
        //                   fontWeight: FontWeight.bold,
        //                   color: appAccentColor)),
        //         ]),
        //   ),
        // ),
      ),
      body: SizedBox(
        child: SfPdfViewer.network(
          notes['wdlink']!,
        ),
      ),
    );
  }
}
