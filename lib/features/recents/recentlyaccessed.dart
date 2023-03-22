import 'package:companion_rebuild/core/provider/notes_provider.dart';
import 'package:companion_rebuild/features/auth/controller/auth_controller.dart';
import 'package:companion_rebuild/features/components/custom_appbar.dart';
import 'package:companion_rebuild/modal/notes_modal.dart';
import 'package:companion_rebuild/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class RecentlyAccessedPage extends ConsumerStatefulWidget {
  const RecentlyAccessedPage({super.key});

  @override
  ConsumerState<RecentlyAccessedPage> createState() =>
      _RecentlyAccessedPageState();
}

class _RecentlyAccessedPageState extends ConsumerState<RecentlyAccessedPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final user = ref.watch(userProvider);
    final allnotes = ref.read(notesDataProvider);
    List<Notes> allnoteslist;
    var userrecentlyaccessed = user!.recentlyAccessed;
    List<Notes> recentlyaccessed = [];

    // print(userbookmarklist);
    List<Notes> getRecentlyAccessed() {
      allnotes.when(
          data: (notes) {
            allnoteslist = notes;
            // print(allnoteslist);
            for (var i = 0; i < userrecentlyaccessed.length; i++) {
              for (var j = 0; j < allnoteslist.length; j++) {
                if (userrecentlyaccessed[i].toString() ==
                    allnoteslist[j].id.toString()) {
                  recentlyaccessed.add(allnoteslist[j]);
                }
              }
            }
            recentlyaccessed = new List.from(recentlyaccessed.reversed);
            recentlyaccessed = recentlyaccessed.toSet().toList();
            return recentlyaccessed;
          },
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => const CircularProgressIndicator());
      return recentlyaccessed;
    }

    List<Notes> recentlyAccessed = getRecentlyAccessed();
    return Scaffold(
        appBar: CustomAppBar(
          title: "Recently Accessed",
        ),
        body: (user.recentlyAccessed.isNotEmpty)
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
                            Notes note = recentlyAccessed[index];
                            return ZoomTapAnimation(
                              child: ListTile(
                                trailing: Text(
                                  note.unit.toString() + " Unit",
                                  style: const TextStyle(color: appGreyColor),
                                ),
                                onTap: () {
                                  ref
                                      .read(authControllerProvider.notifier)
                                      .incrementNotesOpened(
                                        context,
                                        user.id,
                                        note.id.toString(),
                                        note.name,
                                        note.course,
                                        note.unit,
                                      );

                                  Routemaster.of(context)
                                      .push('/pdfview', queryParameters: {
                                    'id': note.id.toString(),
                                    'name': note.name,
                                    'year': note.year,
                                    'branch': note.branch,
                                    'course': note.course,
                                    'semester': note.semester,
                                    'version': note.version,
                                    'unit': note.unit,
                                    'wdlink': note.wdlink,
                                  });
                                },
                                onLongPress: () => Routemaster.of(context)
                                    .push('/notesmenu', queryParameters: {
                                  'id': note.id.toString(),
                                  'name': note.name,
                                  'year': note.year,
                                  'branch': note.branch,
                                  'course': note.course,
                                  'semester': note.semester,
                                  'version': note.version,
                                  'unit': note.unit,
                                  'wdlink': note.wdlink,
                                }),
                                title: Text(recentlyAccessed[index].name),
                                subtitle: Text(
                                  recentlyAccessed[index].course,
                                  style: const TextStyle(color: appGreyColor),
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
