import 'dart:async';
import 'dart:math';

import './models/poster_card_model.dart';
import 'fake_data/fake_recomended_data.dart';

abstract class RecomendedRepository {
  Future<List<PosterCardModel>> fetchRecomendedList(String country);
}

class FakeRecomendedRepository implements RecomendedRepository {
  @override
  Future<List<PosterCardModel>> fetchRecomendedList(String country) {
    return Future.delayed(Duration(seconds: 2), () {
      final random = Random();

      // Uncoment to get error chance by 50:50
      // if (random.nextBool()) {
      //   throw Exception;
      // }

      return FakeRecomendedData.getRecomendedList();
    });
  }
}
