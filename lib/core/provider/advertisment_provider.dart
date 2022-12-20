import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notesapp/core/services/advertisment_api.dart';
import 'package:notesapp/modal/advertisment.dart';

final advertismentDataProvider = FutureProvider<List<Advertisment>>((ref) async {
  return ref.watch(advertismentProvider).getAdvertisment();
});
