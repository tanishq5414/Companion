import 'package:companion_rebuild/core/keys/notes_api.dart';
import 'package:companion_rebuild/modal/notes_modal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final notesDataProvider = FutureProvider<List<Notes>>((ref) async {
  return ref.watch(notesProvider).getNotes();
});
