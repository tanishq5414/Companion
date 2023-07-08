import 'package:companion/config/config.dart';
import 'package:companion/core/core.dart';
import 'package:companion/model/advertisment.model.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final advertisementAPIProvider = Provider((ref) => AdvertisementAPI());

abstract class IAdvertisementAPI {
  FutureEither<List<AdvertismentModel>> getAdvertisements();
}

class AdvertisementAPI implements IAdvertisementAPI {
  final Dio dio = Dio();

  @override
  FutureEither<List<AdvertismentModel>> getAdvertisements() async {
    try {
      final advertisementData = await dio.get(advertismentURL);
      List<AdvertismentModel> advertisementsList = [];
      advertisementData.data.forEach((element) {
        advertisementsList.add(AdvertismentModel.fromJson(element));
      });
      return right(advertisementsList);
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }
}
