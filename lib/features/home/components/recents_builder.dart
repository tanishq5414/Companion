// ignore_for_file: unnecessary_new

import 'package:companion_rebuild/features/components/notes_preview.dart';
import 'package:companion_rebuild/modal/notes_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


recentsBuilder(Size size, AsyncValue<List<Notes>> notesData) {
  return notesData.when(
    data: (notesData) {
      List<Notes> noteList = notesData.map((e) => e).toList();
      var recentList = new List.from(noteList.reversed);
      return SizedBox(
        height: size.width * 0.43,
        child: ListView.builder(
            itemCount: recentList.length>9?9:recentList.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => NotesPreview(
                id: recentList[index].id,
                name: recentList[index].name,
                year: recentList[index].year,
                branch: recentList[index].branch,
                course: recentList[index].course,
                semester: recentList[index].semester,
                version: recentList[index].version,
                unit: recentList[index].unit,
                wdlink: recentList[index].wdlink,
                pressable: true)),
      );
    },
    error: (err, s) => Text(err.toString()),
    loading: () => const Center(
      child: CircularProgressIndicator(),
    ),
  );
}
