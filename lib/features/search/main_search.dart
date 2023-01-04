import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notesapp/core/provider/notes_provider.dart';
import 'package:notesapp/modal/courses_modal.dart';
import 'package:notesapp/modal/notes_modal.dart';
import 'package:notesapp/theme/colors.dart';
import 'package:routemaster/routemaster.dart';

class MainSearchPage extends ConsumerStatefulWidget {
  const MainSearchPage({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends ConsumerState<MainSearchPage> {
  List<Notes> foundedNotes = [];
  List<Notes> _notes = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notes = ref.read(notesDataProvider).value as List<Notes>;
    setState(() {
      foundedNotes = _notes;
    });
  }

  onSearch(String search) {
    setState(() {
      _notes = ref.read(notesDataProvider).value as List<Notes>;
      foundedNotes = _notes
          .where((notes) => notes.name.toLowerCase().contains(search) | notes.course.toLowerCase().contains(search))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBackgroundColor,
        title: Container(
          height: 38,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(2)),
          child: TextField(
            autofocus: true,
            style: TextStyle(color: appBlackColor),
            onChanged: (value) => onSearch(value),
            decoration: InputDecoration(
                filled: true,
                fillColor: appWhiteColor,
                contentPadding: EdgeInsets.all(0),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade500,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide.none),
                hintStyle: TextStyle(fontSize: 14, color: appGreyColor),
                hintText: "Search notes, courses, etc..."),
          ),
        ),
      ),
      body: Container(
        color: appBackgroundColor,
        child: foundedNotes.length > 0
            ? ListView.builder(
                itemCount: foundedNotes.length,
                itemBuilder: (context, index) {
                  return notesComponent(notes: foundedNotes[index]);
                })
            : const Center(
                child: Text(
                "No notes found",
                style: TextStyle(color: appWhiteColor,),
              )),
      ),
    );
  }

  notesComponent({required Notes notes}) {
    return InkWell(
      onTap: () => Routemaster.of(context).push('/pdfview', queryParameters: {
        'id': notes.id.toString(),
        'name': notes.name,
        'year': notes.year,
        'branch': notes.branch,
        'course': notes.course,
        'semester': notes.semester,
        'version': notes.version,
        'unit': notes.unit,
        'wdlink': notes.wdlink,
      }),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: appWhiteColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  notes.name.substring(0, 1).toUpperCase(),
                  style: TextStyle(color: appBlackColor, fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notes.name,
                  style: TextStyle(color: appWhiteColor, fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(notes.course,
                  style: TextStyle(color: appAccentColor, fontSize: 14),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
