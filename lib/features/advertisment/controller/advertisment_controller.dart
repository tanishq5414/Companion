import 'package:companion/apis/advertisment_api.dart';
import 'package:companion/core/core.dart';
import 'package:companion/modal/advertisment.modal.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final advertisementsDataProvider =
    StateProvider<List<AdvertismentModal>?>((ref) => null);

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
    if (internetConnection == false) {
      return;
    }
    final res = await _advertisementAPI.getAdvertisements();
    res.fold(
      (l) => showSnackBar(context, l.message),
      (advertisements) {
        _ref
            .read(advertisementsDataProvider.notifier)
            .update((state) => advertisements);
      },
    );
    state = false;
  }
}
