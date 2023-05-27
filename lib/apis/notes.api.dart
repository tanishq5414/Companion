import 'dart:io';

import 'package:companion/config/config.dart';
import 'package:companion/core/core.dart';
import 'package:companion/features/user/controller/user_controller.dart';
import 'package:companion/modal/notes.modal.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final notesAPIProvider = Provider((ref) => NotesAPI());
final dio = Dio();

abstract class INotesAPI {
  FutureEither<List<NotesModal>> getNotes();
  FutureEither<void> uploadNotes({
    required String name,
    required String year,
    required String branch,
    required String course,
    required String semester,
    required String version,
    required String unit,
    required String author,
    required String authorId,
    required File pdf,
  });
}

class NotesAPI implements INotesAPI {
  @override
  FutureEither<List<NotesModal>> getNotes() async {
    try {
      final notesData = await dio.get(notesUrl);
      List<NotesModal> notesList = [];
      notesData.data['data']['files'].forEach((element) {
        notesList.add(NotesModal.fromJson(element));
      });
      return right(notesList);
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }
  @override
  FutureEither<void> uploadNotes({
    required String name,
    required String year,
    required String branch,
    required String course,
    required String semester,
    required String version,
    required String unit,
    required String author,
    required String authorId,
    required File pdf,
  }) async {
    try {
      FormData data = FormData.fromMap({
        "name": name,
        "year": year,
        "branch": branch,
        "course": course,
        "semester": semester,
        "version": version,
        "unit": unit,
        "author": author,
        "authorId": authorId,
        "pdf": await MultipartFile.fromFile(pdf.path,
            filename: pdf.path.split('/').last),
      });
      await dio.post(uploadNotesUrl, data: data);
      return right(null);
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }
}
