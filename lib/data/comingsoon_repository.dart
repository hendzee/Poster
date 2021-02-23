// import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../modules/services.dart';

import 'fake_data/fake_comingsoon_data.dart';
import '../data/models/poster_card_model.dart';

abstract class ComingSoonRepository {
  Future<List<PosterCardModel>> fetchComingSoonList(String country);
}

class FakeComingSoonRepository implements ComingSoonRepository {
  @override
  Future<List<PosterCardModel>> fetchComingSoonList(String country) {
    return Future.delayed(Duration(seconds: 2), () {
      // final random = Random();

      // Uncoment to get error chance by 50:50
      // if (random.nextBool()) {
      //   throw Exception;
      // }

      return FakeComingSoonData.getComingSoonList();
    });
  }
}

class ImpComingSoonRepository implements ComingSoonRepository {
  @override
  Future<List<PosterCardModel>> fetchComingSoonList(String country) async {
    try {
      var response =
          await http.get(Services.getCommingSoonPoster() + '?country=$country');

      if (response.statusCode == 200) {
        List<PosterCardModel> recomendedList = [];

        var tempDataList = (jsonDecode(response.body)['data']);

        print(tempDataList[0]['photo']);

        for (int i = 0; i < tempDataList.length; i++) {
          recomendedList.add(
            PosterCardModel(
              title: tempDataList[i]['title'],
              description: tempDataList[i]['description'],
              startDate: tempDataList[i]['start_date'],
              endDate: tempDataList[i]['end_date'],
              location: tempDataList[i]['location'],
              posterImage: tempDataList[i]['image'],
              userPhoto: tempDataList[i]['photo'],
            ),
          );
        }

        return recomendedList;
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
