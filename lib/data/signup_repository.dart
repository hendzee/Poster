import 'dart:convert';

import 'models/user_model.dart';
import 'package:http/http.dart' as http;
import '../modules/services.dart';

abstract class SignupRepository {
  Future<UserModel> registerUser(
    String firstName,
    String lastName,
    String email,
    String password,
  );
}

class ImpSignupRepository extends SignupRepository {
  @override
  Future<UserModel> registerUser(
      String firstName, String lastName, String email, String password) async {
    try {
      var response = await http.post(Services.signup(), body: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password
      });

      if (response.statusCode == 200) {
        UserModel user =
            UserModel.fromMap(jsonDecode(response.body)['data']['user']);

        return user;
      } else {
        var err = jsonDecode(response.body);
        throw (err['message']);
      }
    } catch (e) {
      print('ERROR NICH GAN: ' + e.toString());
      throw (e);
    }
  }
}
