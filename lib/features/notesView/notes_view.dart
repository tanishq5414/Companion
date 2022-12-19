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
  @override
  Widget build(BuildContext context) {
    
    var flag = 0;
    final user = ref.read(userProvider);
    //get arguments from previous page
    final size = MediaQuery.of(context).size;
    final notes = RouteData.of(context).queryParameters;
    if (user!.bid.contains(notes['id'])) {
      flag = 1;
    }
    void addbookmark() {
      setState(() {
        flag = 1;
      });
      ref
          .read(authControllerProvider.notifier)
          .bookmarkNotes(context, user.id, notes['id']!, user.bid);
    }

    void removebookmark() {
      setState(() {
        flag = 0;
      });
      ref
          .read(authControllerProvider.notifier)
          .bookmarkNotes(context, user.id, notes['id']!, user.bid);
    }

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
          flag == 0
              ? IconButton(
                  icon: Icon(Icons.bookmark_border),
                  onPressed: () => addbookmark(),
                )
              : IconButton(
                  icon: Icon(Icons.bookmark),
                  onPressed: () => removebookmark(),
                ),
          SizedBox(
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
