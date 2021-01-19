import 'models/user_model.dart';

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
      // This is dummy data and should edit soon
      return UserModel(
        id: 'dfalsdfaj',
        email: 'dfaldsf',
        firstName: 'dfaldfa',
        lastName: 'dfaldfja',
        password: 'fdaldkfja',
        phone: '084023242',
      );
    } catch (e) {
      throw (e);
    }
  }
}
