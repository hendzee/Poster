import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/models/user_model.dart';
import '../modules/services.dart';

abstract class UserRepository {
  Future<UserModel> login(String email, String password);
  Future<UserModel> updatePhoto(String userId, String fileName);
  Future<UserModel> updateProfile(
      {String userId,
      String firstName,
      String lastName,
      String phone,
      String email});
}

/// Implement with real data
class ImpUserRepository extends UserRepository {
  @override
  Future<UserModel> login(String email, String password) async {
    try {
      var response =
          await http.get(Services.login() + '?email=$email&password=$password');

      if (response.statusCode == 200) {
        UserModel user =
            UserModel.fromMap(jsonDecode(response.body)['data']['user']);
        return user;
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
  Future<UserModel> updatePhoto(String userId, String fileName) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse(Services.users() + '/$userId'));

      request.files.add(await http.MultipartFile.fromPath('photo', fileName));

      http.Response response =
          await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        UserModel user = UserModel.fromMap(jsonDecode(response.body)['data']);

        return user;
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
  Future<UserModel> updateProfile(
      {String userId,
      String firstName,
      String lastName,
      String phone,
      String email}) {
    throw UnimplementedError();
  }
}
