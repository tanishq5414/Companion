import 'package:flutter/material.dart';
import 'package:notesapp/pages/components/notes_preview.dart';
import 'package:notesapp/provider/get_notes.dart';

import '../../domain/notes_modal.dart';

FutureBuilder<List<Notes>> notesBuilder(Size size) {
  return FutureBuilder<List<Notes>>(
    future: GetNotes.getNotes(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        var i = 0;
        return SizedBox(
          height: size.width * 0.34,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              i = i + 1;
              if (i >= 3) {
                i = 0;
              }
              return NotesPreview(
                name: snapshot.data![index].name,
                year: snapshot.data![index].year,
                branch: snapshot.data![index].branch,
                course: snapshot.data![index].course,
                semester: snapshot.data![index].semester,
                version: snapshot.data![index].version,
                unit: snapshot.data![index].unit,
                wdlink: snapshot.data![index].wdlink,
                index: i,
              );
            },
          ),
        );
      } else if (snapshot.hasError) {
        return const Text('Check your internet connection');
      }
      return const CircularProgressIndicator();
    },
  );
}
