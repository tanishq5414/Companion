import 'package:companion/common/common.dart';
import 'package:companion/features/notes/controller/notes_controller.dart';
import 'package:companion/features/user/controller/user_controller.dart';
import 'package:companion/modal/notes.modal.dart';
import 'package:companion/theme/pallete.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

    final user = ref.watch(userDataProvider);
    final allnotes = ref.read(notesDataProvider);
    List<NotesModal> allnoteslist;
    var userrecentlyaccessed = user!.recentlyAccessed;
    List<NotesModal> recentlyaccessed = [];
    List<NotesModal> getRecentlyAccessed() {
      allnoteslist = allnotes!;
      for (var i = 0; i < userrecentlyaccessed!.length; i++) {
        for (var j = 0; j < allnoteslist.length; j++) {
          if (userrecentlyaccessed[i].toString() ==
              allnoteslist[j].fileId.toString()) {
            recentlyaccessed.add(allnoteslist[j]);
          }
        }
      }
      recentlyaccessed = List.from(recentlyaccessed.reversed);
      recentlyaccessed = recentlyaccessed.toSet().toList();
      return recentlyaccessed;
    }

    List<NotesModal> recentlyAccessed = getRecentlyAccessed();
    return Scaffold(
        appBar: CustomAppBar(
          title: "Recently accessed",
        ),
        body: (user.recentlyAccessed!.isNotEmpty)
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.02),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: recentlyaccessed.length > 20
                              ? 20
                              : recentlyaccessed.length,
                          itemBuilder: (context, index) {
                            recentlyAccessed.reversed;
                            NotesModal note = recentlyAccessed[index];
                            return ZoomTapAnimation(
                              child: ListTile(
                                trailing: Text(
                                  note.unit.toString() + " Unit",
                                  style: const TextStyle(
                                      color: Pallete.lightGreyColor),
                                ),
                                onTap: () {
                                  // TODO: Add recently accessed
                                  // ref
                                  //     .read(.notifier)
                                  //     .incrementNotesOpened(
                                  //       context,
                                  //       user.id,
                                  //       note.id.toString(),
                                  //       note.name,
                                  //       note.course,
                                  //       note.unit,
                                  //     );

                                  // Routemaster.of(context)
                                  //     .push('/pdfview', queryParameters: {
                                  //   'id': note.id.toString(),
                                  //   'name': note.name,
                                  //   'year': note.year,
                                  //   'branch': note.branch,
                                  //   'course': note.course,
                                  //   'semester': note.semester,
                                  //   'version': note.version,
                                  //   'unit': note.unit,
                                  //   'wdlink': note.wdlink,
                                  // });
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
              ));
  }
}
