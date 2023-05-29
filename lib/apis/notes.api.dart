import 'dart:convert';
import 'dart:io';

import 'package:companion/config/config.dart';
import 'package:companion/core/core.dart';
import 'package:companion/modal/notes.modal.dart';
import 'package:companion/modal/trending.modal.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final notesAPIProvider = Provider((ref) => NotesAPI());
final dio = Dio();

abstract class INotesAPI {
  FutureEither<List<NotesModal>> getNotes(String token);
  FutureEither<List<NotesModal>> getTrendingNotesDay();
  FutureEither<List<NotesModal>> getTreandingNotesWeek();
  FutureVoid addTrendingData({required List<TrendingModal> trendingData});
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
  FutureEither<List<NotesModal>> getNotes(String token) async {
    try {
      dio.options.headers['authorization'] = token;
      final notesData = await dio.get(
        notesUrl,
      );
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

  @override
  FutureEither<List<NotesModal>> getTreandingNotesWeek() async {
    try {
      final notesData = await dio.get(trendingNotesByWeekURL);
      List<NotesModal> notesList = [];
      notesData.data['data']['trending'].forEach((element) {
        notesList.add(NotesModal.fromJson(element));
      });
      return right(notesList);
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  FutureEither<List<NotesModal>> getTrendingNotesDay() async {
    try {
      final notesData = await dio.get(trendingNotesByDayURL);

      List<NotesModal> notesList = [];
      notesData.data['data']['trending'].forEach((element) {
        notesList.add(NotesModal.fromJson(element));
      });
      return right(notesList);
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  FutureVoid addTrendingData(
      {required List<TrendingModal> trendingData}) async {
    try {
      
      var options = Options(
        contentType: 'application/json',
      );
      final res = await dio.post(
        trendingNotesDataURL,
        data: {
          "key": trendingData.map((e) => e.toJson()).toList(),
        },
        options: options,
      );
    } catch (e, st) {
      print(e);
      print(st);
    }
  }
}
