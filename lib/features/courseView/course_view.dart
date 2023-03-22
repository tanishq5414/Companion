// ignore_for_file: unnecessary_string_interpolations

import 'package:companion_rebuild/core/provider/courses_provider.dart';
import 'package:companion_rebuild/core/provider/notes_provider.dart';
import 'package:companion_rebuild/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:routemaster/routemaster.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../modal/notes_modal.dart';
import '../../theme/colors.dart';
import '../components/custom_appbar.dart';

class CourseViewPage extends ConsumerWidget {
  const CourseViewPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var size = MediaQuery.of(context).size;
    var params = RouteData.of(context).queryParameters;
    var courseId = params['id'];
    var courseName = params['name'];
    var courseData = ref.watch(coursesDataProvider);

    var notesData = ref.watch(notesDataProvider);
    var user = ref.watch(userProvider)!;
    getnotes(List gids) {
      //get notes for the course gid
      List<Notes> notes = [];
      for (var i = 0; i < gids.length; i++) {
        notesData.when(
            data: ((data) {
              var gid = gids[i];
              for (var j = 0; j < data.length; j++) {
                if (data[j].id.toString() == gid.toString()) {
                  notes.add(data[j]);
                }
              }
              notes.sort((a, b) => a.unit.compareTo(b.unit));
            }),
            error: ((error, stackTrace) => Text(error.toString())),
            loading: () => const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ));
      }
      return notes;
    }

    return SafeArea(
      child: Scaffold(
          appBar: CustomAppBar(
            title: '',
          ),
          body: courseData.when(
              data: ((data) {
                var course = data.firstWhere(
                    (element) => element.cid.toString() == courseId);
                var gid = course.gid;
                List<Notes> notes = getnotes(gid);

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.08,
                      ),
                      Container(
                        margin: EdgeInsets.all(size.width * 0.04),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(courseName.toString(),
                                  style: const TextStyle(
                                      color: appAccentColor,
                                      overflow: TextOverflow.visible,
                                      fontSize: 50,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ],
                        ),
                      ),
                      (notes.length != 0)
                          ? Container(
                              margin: EdgeInsets.all(size.width * 0.02),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: notes.length,
                                  itemBuilder: (context, index) {
                                    return ZoomTapAnimation(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: size.width * 0.02),
                                        child: Container(
                                          // decoration: BoxDecoration(
                                          //     border: Border.fromBorderSide(
                                          //         color: appWhiteColor,
                                          //         width: 1)),
                                          child: ListTile(
                                            onLongPress: () =>
                                                Routemaster.of(context).push(
                                                    '/notesmenu',
                                                    queryParameters: {
                                                  'id': notes[index]
                                                      .id
                                                      .toString(),
                                                  'name': notes[index].name,
                                                  'year': notes[index].year,
                                                  'branch': notes[index].branch,
                                                  'course': notes[index].course,
                                                  'semester':
                                                      notes[index].semester,
                                                  'version':
                                                      notes[index].version,
                                                  'unit': notes[index].unit,
                                                  'wdlink': notes[index].wdlink,
                                                }),
                                            onTap: () {
                                              ref
                                                  .read(authControllerProvider
                                                      .notifier)
                                                  .incrementNotesOpened(
                                                      context,
                                                      user.id,
                                                      notes[index]
                                                          .id
                                                          .toString(),
                                                      notes[index].name,
                                                      notes[index].course,
                                                      notes[index].unit);
                                              Routemaster.of(context).push(
                                                  '/pdfview',
                                                  queryParameters: {
                                                    'id': notes[index]
                                                        .id
                                                        .toString(),
                                                    'name': notes[index].name,
                                                    'year': notes[index].year,
                                                    'branch':
                                                        notes[index].branch,
                                                    'course':
                                                        notes[index].course,
                                                    'semester':
                                                        notes[index].semester,
                                                    'version':
                                                        notes[index].version,
                                                    'unit': notes[index].unit,
                                                    'wdlink':
                                                        notes[index].wdlink,
                                                  });
                                            },
                                            title: Text(
                                                notes[index].name.toString(),
                                                style: const TextStyle(
                                                    color: appWhiteColor,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            subtitle: Text(
                                                '${notes[index].unit.toString()} Unit ',
                                                style: const TextStyle(
                                                    color: appGreyColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            trailing: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                user.bid.contains(notes[index]
                                                        .id
                                                        .toString())
                                                    ? const Icon(
                                                        OctIcons
                                                            .bookmark_fill_24,
                                                        color: appGreyColor,
                                                      )
                                                    : Container(),
                                                SizedBox(
                                                  width: size.width * 0.04,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          : Padding(
                              padding: EdgeInsets.only(top: size.width * 0.35),
                              child: const Text(
                                'No notes found for this course',
                                style: TextStyle(color: appGreyColor),
                              ),
                            ),
                    ],
                  ),
                );
              }),
              error: ((error, stackTrace) => Text(error.toString())),
              loading: () => const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ))),
    );
  }
}
