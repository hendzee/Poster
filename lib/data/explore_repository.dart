import 'dart:async';
import 'dart:math';

import './fake_data/fake_explore_data.dart';
import './models/poster_card_model.dart';

abstract class ExploreRepository {
  Future<List<PosterCardModel>> fetchData(String country);
}

class FakeExploreRepository implements ExploreRepository {
  @override
  Future<List<PosterCardModel>> fetchData(String country) {
    return Future.delayed(Duration(seconds: 2), () {
      final random = Random();

      if (random.nextBool()) {
        throw Exception;
      }

      return FakeExploreData.getExploreList();
    });
  }
}
