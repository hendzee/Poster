import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:poster/data/models/poster_card_model.dart';
import 'package:poster/modules/services.dart';

abstract class SearchResultRepository {
  Future<Map<String, dynamic>> fetchSearchResult(
      String keyword, String country, String page);
}

class ImpSearchResultRepository implements SearchResultRepository {
  @override
  Future<Map<String, dynamic>> fetchSearchResult(
      String keyword, String country, String page) async {
    try {
      var response = await http.get(Services.getSearchResult() +
          '?keyword=$keyword&country=$country&page=$page');

      if (response.statusCode == 200) {
        List<PosterCardModel> searchResultList = [];

        var tempDataList = (jsonDecode(response.body)['data']);

        for (int i = 0; i < tempDataList.length; i++) {
          searchResultList.add(
            PosterCardModel.fromMap(tempDataList[i]),
          );
        }

        return {
          'data': searchResultList,
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
