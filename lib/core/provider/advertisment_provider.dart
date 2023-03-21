import 'package:companion_rebuild/core/services/advertisment_api.dart';
import 'package:companion_rebuild/modal/advertisment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final advertismentDataProvider = FutureProvider<List<Advertisment>>((ref) async {
  return ref.watch(advertismentProvider).getAdvertisment();
});
