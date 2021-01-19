part of 'signup_cubit.dart';

@immutable
abstract class SignupState {
  const SignupState();
}

class SignupInitial extends SignupState {
  const SignupInitial();
}

class SignupLoading extends SignupState {
  const SignupLoading();
}

class SignupError extends SignupState {
  final String message;

  const SignupError({this.message});
}

class SignupProfileSaved extends SignupState {
  final String firstName;
  final String lastName;
  final String email;

  const SignupProfileSaved({this.firstName, this.lastName, this.email});
}

class SignupSucceded extends SignupState {
  final UserModel user;

  const SignupSucceded({this.user});
}
