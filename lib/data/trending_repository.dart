import 'dart:async';
import 'dart:io';
import 'dart:math';

import './models/poster_card_model.dart';
import '../data/fake_data/trending_data.dart'; // Fake trending data

abstract class TrendingRepository {
  Future<PosterCardModel> fetchTrending(String country);
}

class FakeTrendingRepository implements TrendingRepository {
  @override
  Future<PosterCardModel> fetchTrending(String country) {
    return Future.delayed(Duration(seconds: 2), () {
      final random = Random();

      // Fake network error
      if (random.nextBool()) {
        throw Exception;
      }

      return FakeTrendingData.getTrendingCountry();
    });
  }
}
