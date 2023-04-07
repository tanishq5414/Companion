// ignore_for_file: unnecessary_new

import 'package:companion_rebuild/features/components/notes_preview.dart';
import 'package:companion_rebuild/modal/notes_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


trendingbuilder(Size size, List<Notes> notesData) {
      return SizedBox(
        height: size.width * 0.43,
        child: ListView.builder(
            itemCount: notesData.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => NotesPreview(
                id: notesData[index].id,
                name: notesData[index].name,
                year: notesData[index].year,
                branch: notesData[index].branch,
                course: notesData[index].course,
                semester: notesData[index].semester,
                version: notesData[index].version,
                unit: notesData[index].unit,
                wdlink: notesData[index].wdlink,
                pressable: true)),
      );
    }
