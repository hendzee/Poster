import 'dart:async';
import 'dart:convert';
// import 'dart:math';
import 'package:http/http.dart' as http;
import '../modules/services.dart';

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

class ImpTrendingRepository implements TrendingRepository {
  @override
  Future<PosterCardModel> fetchTrending(String country) async {
    try {
      var response =
          await http.get(Services.getTrendingPoster() + '?country=$country');

      if (response.statusCode == 200) {
        PosterCardModel poster =
            PosterCardModel.fromMap(jsonDecode(response.body)['data']);

        return poster;
      } else {
        var err = jsonDecode(response.body) != null
            ? jsonDecode(response.body)
            : Services.generealErrorMsg();
        throw (err['message']);
      }
    } catch (e) {
      throw (e);
    }
  }
}
