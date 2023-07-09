import 'package:companion/features/notes/widgets/notes_preview.dart';
import 'package:companion/model/notes.model.dart';
import 'package:flutter/material.dart';

notesBuilder(Size size, List<NotesModel> notesData) {
  return SizedBox(
    height: size.width * 0.52,
    child: ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: notesData.length > 9 ? 9 : notesData.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) => NotesPreview(
        size: size,
        notes: notesData[index],
      ),
    ),
  );
}
