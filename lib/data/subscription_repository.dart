import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/models/poster_card_model.dart';
import '../modules/services.dart';

abstract class SubscriptionRepository {
  Future<Map<String, dynamic>> fetchSubscriptionList(
      String userId, String page);
}

class ImpSubscriptionRepository implements SubscriptionRepository {
  @override
  Future<Map<String, dynamic>> fetchSubscriptionList(
      String userId, String page) async {
    try {
      var response = await http
          .get(Services.getUserSubscription() + '?id=$userId&page=$page');

      if (response.statusCode == 200) {
        List<PosterCardModel> subscribtionList = [];

        var tempDataList = (jsonDecode(response.body)['data']);

        for (int i = 0; i < tempDataList.length; i++) {
          subscribtionList.add(
            PosterCardModel.fromMap(tempDataList[i]),
          );
        }

        return {
          'data': subscribtionList,
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
