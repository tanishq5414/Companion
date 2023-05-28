import 'package:companion/config/config.dart';
import 'package:companion/core/core.dart';
import 'package:companion/modal/advertisment.modal.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final advertisementAPIProvider = Provider((ref) => AdvertisementAPI());

abstract class IAdvertisementAPI {
  FutureEither<List<AdvertismentModal>> getAdvertisements();
}

class AdvertisementAPI implements IAdvertisementAPI {
  final Dio dio = Dio();

  @override
  FutureEither<List<AdvertismentModal>> getAdvertisements() async {
    try {
      final advertisementData = await dio.get(advertismentURL);
      List<AdvertismentModal> advertisementsList = [];
      advertisementData.data.forEach((element) {
        advertisementsList.add(AdvertismentModal.fromJson(element));
      });
      return right(advertisementsList);
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }
}
