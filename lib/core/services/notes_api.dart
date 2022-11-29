import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../modal/notes_modal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetNotes {
  final notesDataJson =
        'https://tanishq5414.github.io/apiNotesApp/notes.json';
  Future<List<Notes>> getNotes() async {
    final notesData = await http.get(Uri.parse(notesDataJson));
    if (notesData.statusCode == 200) {
      final List jsonResponse = json.decode(notesData.body);
      return jsonResponse.map((notes) => Notes.fromJson(notes)).toList();
    } else {
      throw Exception('Failed to load notes from API');
    }
  }
}

final notesProvider = Provider<GetNotes>((ref) => GetNotes());

