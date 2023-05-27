// ignore_for_file: unused_import, prefer_is_empty

import 'package:companion/features/courses/controller/courses_controller.dart';
import 'package:companion/features/notes/controller/notes_controller.dart';
import 'package:companion/modal/courses.modal.dart';
import 'package:companion/modal/notes.modal.dart';
import 'package:companion/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class MainSearchPage extends ConsumerStatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const MainSearchPage());
  const MainSearchPage({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends ConsumerState<MainSearchPage> {
  TextEditingController editingController = TextEditingController();
  late List<NotesModal> notesList;
  late List<NotesModal> foundedNotes = [];

  @override
  void initState() {
    super.initState();
    notesList = ref.read(notesDataProvider)!;
    notesList.sort((a, b) => a.name!.compareTo(b.name!));
  }

  @override
  void dispose() {
    super.dispose();
    notesList = [];
    editingController.dispose();
  }

  onSearch(query) {
    setState(() {
      foundedNotes = notesList
          .where((element) => element.name!.toLowerCase().contains(query) ||
              element.course!.toLowerCase().contains(query)|| element.author!.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Scaffold(
          appBar: AppBar(
            leading: ZoomTapAnimation(
                child: IconButton(
                    icon: const Icon(
                      OctIcons.arrow_left_16,
                      size: 25,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    })),
            elevation: 0,
            backgroundColor: Pallete.backgroundColor,
            title: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Pallete.whiteColor,
                  borderRadius: BorderRadius.circular(2)),
              child: TextField(
                autofocus: true,
                style: const TextStyle(color: Pallete.blackColor),
                onChanged: (value) => onSearch(value.toLowerCase()),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Pallete.whiteColor,
                    contentPadding: const EdgeInsets.all(0),
                    prefixIcon: const Icon(
                      OctIcons.search_16,
                      size: 20,
                      color: Pallete.greyColor,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none),
                    hintStyle:
                        const TextStyle(fontSize: 14, color: Pallete.greyColor),
                    hintText: "Search notes, courses, etc..."),
              ),
            ),
          ),
          body: Container(
            margin: EdgeInsets.only(top: size.width * 0.05),
            color: Pallete.backgroundColor,
            child: foundedNotes.length > 0
                ? ListView.builder(
                    itemCount:
                        foundedNotes.length > 15 ? 15 : foundedNotes.length,
                    itemBuilder: (context, index) {
                      return notesComponent(notes: foundedNotes[index]);
                    })
                : Center(
                    child: (editingController.value.text.isNotEmpty)
                        ? const Text(
                            'No result found',
                            style: TextStyle(
                                color: Pallete.whiteColor,
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          )
                        : const Text(
                            'Try Searching Something...',
                            style: TextStyle(
                                color: Pallete.whiteColor,
                                fontSize: 24,
                                fontWeight: FontWeight.w900),
                          ),
                  ),
          ),
        ),
      ),
    );
  }

  notesComponent({required NotesModal notes}) {
    return InkWell(
      onTap: () {
        //TODO:  Implement Pdf View navigation
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
                    style: const TextStyle(
                        color: Pallete.whiteColor, fontSize: 16),
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
              style:
                  const TextStyle(color: Pallete.lightGreyColor, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
