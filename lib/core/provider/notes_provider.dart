import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notesapp/core/services/notes_api.dart';
import 'package:notesapp/modal/notes_modal.dart';

final notesDataProvider = FutureProvider<List<Notes>>((ref) async {
  return ref.watch(notesProvider).getNotes();
});
