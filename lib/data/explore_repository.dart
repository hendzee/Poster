import 'dart:async';
// import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../modules/services.dart';
import './models/poster_card_model.dart';

abstract class ExploreRepository {
  Future<Map<String, dynamic>> fetchData(String country, String page);
}

class ImpExploreRepository implements ExploreRepository {
  @override
  Future<Map<String, dynamic>> fetchData(String country, String page) async {
    try {
      var response =
          await http.get(Services.posters() + '?country=$country&page=$page');

      if (response.statusCode == 200) {
        List<PosterCardModel> exploreList = [];

        var tempDataList = (jsonDecode(response.body)['data']);

        for (int i = 0; i < tempDataList.length; i++) {
          exploreList.add(
            PosterCardModel.fromMap(tempDataList[i]),
          );
        }

        return {
          'data': exploreList,
          'currentPage': jsonDecode(response.body)['current_page'].toString(),
          'lastPage': jsonDecode(response.body)['last_page'].toString(),
        };
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
