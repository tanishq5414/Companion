import 'package:companion/features/hive/boxes.dart';
import 'package:companion/features/notes/views/notes_menu.dart';
import 'package:companion/features/notes/views/notes_pdf_view.dart';
import 'package:companion/modal/notes.modal.dart';
import 'package:companion/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

notesComponent({required NotesModal notes, required BuildContext context}) {
  return InkWell(
    onLongPress: () {
      Navigator.push(context, NotesMenu.route(notes: notes));
    },
    onTap: () {
      recentlyAccessedBox.add(
          [notes.fileId!, DateTime.now().millisecondsSinceEpoch.toString()]);
      trendingBox.add(notes.fileId!);
      Navigator.push(context, NotesPdfView.route(notes: notes));
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          ZoomTapAnimation(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notes.name ?? '',
                  style:
                      const TextStyle(color: Pallete.whiteColor, fontSize: 16),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  notes.course ?? 'Course Name',
                  style: const TextStyle(
                      color: Pallete.lightGreyColor, fontSize: 14),
                ),
              ],
            ),
          ),
          Spacer(),
          Text(
            '${notes.unit} Unit',
            style: const TextStyle(color: Pallete.lightGreyColor, fontSize: 14),
          ),
        ],
      ),
    ),
  );
}
