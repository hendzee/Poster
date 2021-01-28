import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/user_model.dart';

class LocalData {
  /// Set user data to local storage
  static void setUserLocalData(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('id', user.id);
    prefs.setString('firstName', user.firstName);
    prefs.setString('lastName', user.lastName);
    prefs.setString('photo', user.photo);
    prefs.setString('country', user.country);
    prefs.setString('email', user.email);
    prefs.setString('phone', user.phone);
    prefs.setString('password', user.password);
  }

  /// Get user data from local storage
  static Future<UserModel> getUserLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    UserModel user = UserModel(
      id: prefs.getString('id'),
      firstName: prefs.getString('firstName'),
      lastName: prefs.getString('lastName'),
      country: prefs.getString('country'),
      photo: prefs.getString('photo'),
      email: prefs.getString('email'),
      phone: prefs.getString('phone'),
      password: prefs.getString('password'),
    );

    return user;
  }

  /// Set login flag data to local storage
  static void setLoginLocalData(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', status);
  }

  /// Get login flag data to local storage
  static Future<bool> getLoginLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('isLogin') == null) {
      return false;
    }

    return true;
  }
}
