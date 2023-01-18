import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../modal/notes_modal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetNotes {
  final notesDataJson = 'http://10.0.2.2:3000/api/v1/getFiles';
  Future<List<Notes>> getNotes() async {
    final response = await http.get(Uri.parse(notesDataJson));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      // print(jsonResponse);
      List<Notes> notes = [];
      for (var item in jsonResponse['files']) {
        notes.add(Notes.fromJson(item));
      }
      return notes;
    } else {
      throw Exception('Failed to load courses from API');
    }
  }
}

final notesProvider = Provider<GetNotes>((ref) => GetNotes());
