import 'dart:convert';

import '../data/models/user_model.dart';
import 'package:http/http.dart' as http;
import '../modules/services.dart';

abstract class UserRepository {
  Future<UserModel> login(String email, String password);
}

/// Implement with real data
class ImpUserRepository extends UserRepository {
  @override
  Future<UserModel> login(String email, String password) async {
    var response =
        await http.get(Services.login() + '?email=$email&password=$password');

    try {
      if (response.statusCode == 200) {
        UserModel user =
            UserModel.fromMap(jsonDecode(response.body)['data']['user']);
        return user;
      } else {
        var err = jsonDecode(response.body);
        throw (err['message']);
      }
    } catch (e) {
      throw (e);
    }
  }
}
