import 'dart:convert';

import 'package:companion/apis/advertisment_api.dart';
import 'package:companion/core/core.dart';
import 'package:companion/features/hive/boxes.dart';
import 'package:companion/model/advertisment.model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final advertisementsDataProvider =
    StateProvider<List<AdvertismentModel>?>((ref) => null);

final advertisementControllerProvider =
    StateNotifierProvider<AdvertisementController, bool>((ref) {
  return AdvertisementController(
    ref: ref,
    advertisementAPI: ref.read(advertisementAPIProvider),
  );
});

class AdvertisementController extends StateNotifier<bool> {
  final IAdvertisementAPI _advertisementAPI;
  final Ref _ref;

  AdvertisementController(
      {required Ref ref, required AdvertisementAPI advertisementAPI})
      : _ref = ref,
        _advertisementAPI = advertisementAPI,
        super(false);

  Future<void> getAdvertisements(
      BuildContext context, bool internetConnection) async {
    state = true;
    if (internetConnection == true) {
      final res = await _advertisementAPI.getAdvertisements();
      res.fold(
        (l) => showSnackBar(context, l.message),
        (advertisements) {
          _ref
              .read(advertisementsDataProvider.notifier)
              .update((state) => advertisements);
          networkCache.put(
            'getAdvertisements',
            advertisements.map((e) => jsonEncode(e.toJson())).toList(),
          );
        },
      );
    }

    if (internetConnection == false) {
      final notes = networkCache.get('getAdvertisements');
      if (notes != null) {
        final List<String> getAdvertisments = notes.cast<String>();
        List<AdvertismentModel> notesList = [];
        getAdvertisments.forEach((noteString) {
          final Map<String, dynamic> noteMap = jsonDecode(noteString);
          notesList.add(AdvertismentModel.fromJson(noteMap));
        });
        _ref.read(advertisementsDataProvider.notifier).update((state) => notesList);
      }
    }

    state = false;
  }
}
