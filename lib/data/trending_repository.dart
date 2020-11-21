import 'dart:async';
// import 'dart:math';

import './models/poster_card_model.dart';
import 'fake_data/fake_trending_data.dart'; // Fake trending data

abstract class TrendingRepository {
  Future<PosterCardModel> fetchTrending(String country);
}

class FakeTrendingRepository implements TrendingRepository {
  @override
  Future<PosterCardModel> fetchTrending(String country) {
    return Future.delayed(Duration(seconds: 2), () {
      // final random = Random();

      // Uncoment to get error chance by 50:50
      // if (random.nextBool()) {
      //   throw Exception;
      // }

      return FakeTrendingData.getTrendingCountry();
    });
  }
}
