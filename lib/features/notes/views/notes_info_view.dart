import 'package:companion/features/notes/widgets/notes_preview.dart';
import 'package:companion/features/user/controller/user_controller.dart';
import 'package:companion/model/notes.model.dart';
import 'package:companion/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class NotesInfoView extends ConsumerStatefulWidget {
  static Route route({required NotesModel notes}) {
    return MaterialPageRoute<void>(builder: (_) => NotesInfoView(notes: notes));
  }

  final NotesModel notes;
  const NotesInfoView({super.key, required this.notes});

  @override
  ConsumerState<NotesInfoView> createState() => _NotesMenuState();
}

class _NotesMenuState extends ConsumerState<NotesInfoView> {
  @override
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(int.parse(widget.notes.createdAt!));
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black,
            Colors.black,
          ],
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: EdgeInsets.only(top: size.height * 0.26),
              height: size.height * 0.8,
              width: size.width,
              child: Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.12, right: size.width * 0.12),
                child: Column(
                  verticalDirection: VerticalDirection.up,
                  children: [
                    SizedBox(height: size.height * 0.1),
                    Text(
                      'Course: ${widget.notes.course!}',
                      style: TextStyle(color: Pallete.whiteColor),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      'Year: ${widget.notes.year!}',
                      style: TextStyle(color: Pallete.whiteColor),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      'Semester: ${widget.notes.semester!}',
                      style: TextStyle(color: Pallete.whiteColor),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      'Unit: ${widget.notes.unit!}',
                      style: TextStyle(color: Pallete.whiteColor),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      'Branch: ${widget.notes.branch!}',
                      style: TextStyle(color: Pallete.whiteColor),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      'Author: ${widget.notes.author!}',
                      style: TextStyle(color: Pallete.whiteColor),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      'Created: ${date}',
                      style: TextStyle(color: Pallete.whiteColor),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      'Name: ${widget.notes.name!}',
                      style: TextStyle(color: Pallete.whiteColor),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Expanded(
                      child: NotesPreview(
                        notes: widget.notes,
                        size: size,
                        disableonTap: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
