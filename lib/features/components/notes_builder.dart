import 'package:companion_rebuild/features/components/notes_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../modal/notes_modal.dart';


notesBuilder(Size size, AsyncValue<List<Notes>> notesData) {
  return notesData.when(
    data: (notesData) {
      List<Notes> noteList = notesData.map((e) => e).toList();
      return SizedBox(
        height: size.width*0.43,
        child: ListView.builder(
            itemCount: noteList.length > 9 ? 9 : noteList.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => NotesPreview(
                id: noteList[index].id,
                name: noteList[index].name,
                year: noteList[index].year,
                branch: noteList[index].branch,
                course: noteList[index].course,
                semester: noteList[index].semester,
                version: noteList[index].version,
                unit: noteList[index].unit,
                wdlink: noteList[index].wdlink,
                pressable: true)),
      );
    },
    error: (err, s) => Text(err.toString()),
    loading: () => const Center(
      child: CircularProgressIndicator(),
    ),
  );
}
