import 'package:companion/common/common.dart';
import 'package:companion/core/providers/dummy_user_provider.dart';
import 'package:companion/features/hive/boxes.dart';
import 'package:companion/features/hive/model/recentlyaccessed.dart';
import 'package:companion/features/notes/controller/notes_controller.dart';
import 'package:companion/features/notes/views/notes_menu.dart';
import 'package:companion/features/notes/views/notes_pdf_view.dart';
import 'package:companion/features/user/controller/user_controller.dart';
import 'package:companion/model/notes.model.dart';
import 'package:companion/theme/pallete.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class RecentlyAccessedView extends ConsumerStatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const RecentlyAccessedView(),
    );
  }

  const RecentlyAccessedView({super.key});

  @override
  ConsumerState<RecentlyAccessedView> createState() =>
      _RecentlyAccessedPageState();
}

class _RecentlyAccessedPageState extends ConsumerState<RecentlyAccessedView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final user = ref.watch(userDataProvider) ?? nullUser;
    final allnoteslist = ref.read(notesDataProvider)!;
    var recentlyAcessedData = recentlyAccessedBox;

    List<NotesModel> recentlyaccessed = [];
    List<NotesModel> getRecentlyAccessed() {
      // }
      Set<String> fileIdSet =
          allnoteslist.map((note) => note.fileId.toString()).toSet();
      for (var data in recentlyAcessedData.values) {
        String fileId = data[0].toString();
        if (fileIdSet.contains(fileId)) {
          NotesModel matchingNote = allnoteslist
              .firstWhere((note) => note.fileId.toString() == fileId);
          recentlyaccessed.add(matchingNote);
        }
      }

      recentlyaccessed = List.from(recentlyaccessed.reversed);
      return recentlyaccessed;
    }

    List<NotesModel> recentlyAccessed = getRecentlyAccessed();
    return Container(
      color: Pallete.backgroundColor,
      child: SafeArea(
        child: Scaffold(
            appBar: CustomAppBar(
              title: "Recently accessed",
            ),
            body: (user!.recentlyAccessed!.isNotEmpty)
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.02),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: recentlyaccessed.length,
                              itemBuilder: (context, index) {
                                recentlyAccessed;
                                NotesModel note = recentlyAccessed[index];
                                return ZoomTapAnimation(
                                  child: ListTile(
                                    trailing: Text(
                                      note.unit.toString() + " Unit",
                                      style: const TextStyle(
                                          color: Pallete.lightGreyColor),
                                    ),
                                    onTap: () {
                                      recentlyAccessedBox.add([
                                        note.fileId!,
                                        DateTime.now()
                                            .millisecondsSinceEpoch
                                            .toString()
                                      ]);
                                      Navigator.push(context,
                                          NotesPdfView.route(notes: note));
                                    },
                                    onLongPress: () {
                                      Navigator.push(context,
                                          NotesMenu.route(notes: note));
                                    },
                                    title: Text(
                                      recentlyAccessed[index].name!,
                                      style: const TextStyle(
                                          color: Pallete.whiteColor),
                                    ),
                                    subtitle: Text(
                                      recentlyAccessed[index].course!,
                                      style: const TextStyle(
                                          color: Pallete.whiteColor,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  )
                : const Center(
                    child: Text("No recently accessed items"),
                  )),
      ),
    );
  }
}
