import 'dart:convert';

import 'package:http/http.dart' as http;

import '../modules/services.dart';

abstract class SubscriberRepository {
  Future<bool> checkSubscriberStatus(String userId, String posterId);
  Future<bool> subscribe(String userId, String posterId);
}

class ImpSubscriberRepository implements SubscriberRepository {
  @override
  Future<bool> checkSubscriberStatus(String userId, String posterId) async {
    try {
      var response = await http.get(Services.checkSubscribeStatus() +
          '?subscriber_id=$userId&poster_id=$posterId');

      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['message'] == 'Data not found') {
          return false;
        }
        return true;
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

  @override
  Future<bool> subscribe(String userId, String posterId) async {
    try {
      var response = await http.post(Services.subscribers(), body: {
        'poster_id': posterId,
        'subscriber_id': userId,
      });

      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['message'] == 'Poster was unsubscribed') {
          return false;
        }
        return true;
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
