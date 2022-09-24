import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../domain/notes_modal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class GetNotes with ChangeNotifier {
  List<Notes> _notesdata = [];
  static Future<List<Notes>> getNotes() async {
    const notesDataJson =
        'https://tanishq5414.github.io/apiNotesApp/notes.json';
    final _notesdata = await http.get(Uri.parse(notesDataJson));
    if (_notesdata.statusCode == 200) {
      final List jsonResponse = json.decode(_notesdata.body);
      return jsonResponse.map((notes) => Notes.fromJson(notes)).toList();

    } else {
      throw Exception('Failed to load notes from API');
    }
  }

  Future<List<Notes>> notesdata = getNotes();
}
