// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notesapp/core/provider/courses_provider.dart';
import 'package:notesapp/core/provider/notes_provider.dart';
import 'package:notesapp/features/auth/controller/auth_controller.dart';
import 'package:notesapp/modal/notes_modal.dart';
import 'package:notesapp/theme/colors.dart';
import 'package:routemaster/routemaster.dart';

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

    return Scaffold(
        appBar: CustomAppBar(
          title: courseName,
        ),
        body: courseData.when(
            data: ((data) {
              var course = data
                  .firstWhere((element) => element.cid.toString() == courseId);
              var gid = course.gid;
              List<Notes> notes = getnotes(gid);
              return Container(
                margin: EdgeInsets.all(size.width * 0.04),
                child: ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: appWhiteColor, width: 1)),
                        child: ListTile(
                          onTap: () {
                            ref
                                .read(authControllerProvider.notifier)
                                .incrementNotesOpened(
                                    context,
                                    user.id,
                                    notes[index].id.toString(),
                                    notes[index].name,
                                    notes[index].course,
                                    notes[index].unit);
                            Routemaster.of(context)
                                .push('/pdfview', queryParameters: {
                              'id': notes[index].id.toString(),
                              'name': notes[index].name,
                              'year': notes[index].year,
                              'branch': notes[index].branch,
                              'course': notes[index].course,
                              'semester': notes[index].semester,
                              'version': notes[index].version,
                              'unit': notes[index].unit,
                              'wdlink': notes[index].wdlink,
                            });
                          },
                          title: Text(notes[index].name.toString(),
                              style: const TextStyle(
                                  color: appWhiteColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500)),
                          subtitle: Text('${notes[index].unit.toString()}',
                              style: const TextStyle(
                                  color: appAccentColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              user.bid.contains(notes[index].id.toString())
                                  ? IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.bookmark,
                                        color: appGreyColor,
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      );
                    }),
              );
            }),
            error: ((error, stackTrace) => Text(error.toString())),
            loading: () => const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )));
  }
}
