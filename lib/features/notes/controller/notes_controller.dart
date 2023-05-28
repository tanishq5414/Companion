import 'dart:io';

import 'package:companion/apis/notes.api.dart';
import 'package:companion/core/core.dart';
import 'package:companion/features/hive/boxes.dart';
import 'package:companion/modal/notes.modal.dart';
import 'package:companion/modal/trending.modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notesDataProvider = StateProvider<List<NotesModal>?>((ref) => null);
final trendingNotesDailyProvider =
    StateProvider<List<NotesModal>?>((ref) => null);
final trendingNotesWeeklyProvider =
    StateProvider<List<NotesModal>?>((ref) => null);
final notesControllerProvider =
    StateNotifierProvider<NotesController, bool>((ref) {
  final notesAPI = ref.watch(notesAPIProvider);
  return NotesController(
    ref: ref,
    notesAPI: notesAPI,
  );
});

class NotesController extends StateNotifier<bool> {
  final NotesAPI _notesAPI;
  final Ref _ref;
  NotesController({required NotesAPI notesAPI, required Ref ref})
      : _notesAPI = notesAPI,
        _ref = ref,
        super(false);

  Future<void> getNotes(BuildContext context) async {
    state = true;
    final res = await _notesAPI.getNotes();
    res.fold((l) => showSnackBar(context, l.message), (notes) {
      _ref.read(notesDataProvider.notifier).update((state) => notes);
    });
    state = false;
  }

  Future<void> getTrendingNotes(BuildContext context) async {
    state = true;
    final res = await _notesAPI.getTrendingNotesDay();
    res.fold((l) => showSnackBar(context, l.message), (notes) {
      _ref.read(trendingNotesDailyProvider.notifier).update((state) => notes);
    });
    final res2 = await _notesAPI.getTreandingNotesWeek();
    res2.fold((l) => showSnackBar(context, l.message), (notes) {
      _ref.read(trendingNotesWeeklyProvider.notifier).update((state) => notes);
    });
    state = false;
  }

  Future<void> uploadNotes({
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
    required BuildContext context,
  }) async {
    state = true;
    final res = await _notesAPI.uploadNotes(
      name: name,
      year: year,
      branch: branch,
      course: course,
      semester: semester,
      version: version,
      unit: unit,
      author: author,
      authorId: authorId,
      pdf: pdf,
    );
    res.fold((l) => showSnackBar(context, l.message), (r) {
      showSnackBar(context, "Notes Uploaded Successfully");
    });
    state = false;
  }

  FutureVoid addDataForTrendingNotes() async {
    if (trendingBox.length < 40) {
      return;
    }
    List<String> a = trendingBox.values.toList().cast<String>();
    List<TrendingModal> convertToList(List<String> inputList) {
      final Map<String, int> counts = {};

      for (final String? fileId in inputList) {
        if (fileId != null) {
          if (counts.containsKey(fileId)) {
            counts[fileId] = (counts[fileId] ?? 0) + 1;
          } else {
            counts[fileId] = 1;
          }
        }
      }

      // Create a list of TrendingModal objects
      final List<TrendingModal> trendingList = counts.entries
          .map((entry) => TrendingModal(
              fileId: entry.key,
              accessToday: entry.value,
              accessWeekly: entry.value))
          .toList();

      return trendingList;
    }

    var trendingData = convertToList(a);
    await _notesAPI.addTrendingData(trendingData: trendingData);
  }
}
