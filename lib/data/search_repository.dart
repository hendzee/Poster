import 'dart:convert';

import 'package:http/http.dart' as http;

import '../modules/services.dart';

abstract class SearchRepository {
  Future<List<String>> fetchSugestionList(String keyword);
}

class ImpSearchRepository extends SearchRepository {
  @override
  Future<List<String>> fetchSugestionList(String keyword) async {
    try {
      var response =
          await http.get(Services.getSugestionSearch() + '?keyword=$keyword');

      if (response.statusCode == 200) {
        List<String> listTitle = [];
        var tempData = jsonDecode(response.body)['data'];

        if (tempData.length > 0) {
          for (int i = 0; i < tempData.length; i++) {
            listTitle.add(tempData[i]['title']);
          }
        }

        return listTitle;
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
