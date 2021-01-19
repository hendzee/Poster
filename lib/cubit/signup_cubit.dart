import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poster/data/models/user_model.dart';
import 'package:poster/data/signup_repository.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupRepository _signupRepository;
  String _firstName;
  String _lastName;
  String _email;
  String _password;

  SignupCubit(this._signupRepository) : super(SignupInitial());

  /// Register step one: Name and email
  Future<Void> registerProfile(
      String firstName, String lastName, String email) {
    emit(SignupLoading());

    try {
      _firstName = firstName;
      _lastName = lastName;
      _email = email;

      emit(SignupProfileSaved(
          firstName: firstName, lastName: lastName, email: email));
    } catch (e) {
      emit(SignupError(message: 'Something went wrong, please try again'));
    }
  }

  /// Register user to database
  Future<Void> registerUser(password) async {
    emit(SignupLoading());

    _password = password;

    try {
      UserModel userModel = await _signupRepository.registerUser(
          _firstName, _lastName, _email, _password);

      emit(SignupSucceded(user: userModel));
    } catch (e) {
      emit(SignupError(message: e));
    }
  }
}
