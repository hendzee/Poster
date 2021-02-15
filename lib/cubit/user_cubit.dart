import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poster/data/user_repository.dart';

import '../data/models/user_model.dart';
import '../modules/local_data.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;
  UserModel user;
  bool isLogin;

  UserCubit(this.userRepository) : super(UserInitial());

  /// Input data local when login
  Future<void> login(String email, String password) async {
    emit(UserLoading());

    try {
      user = await userRepository.login(email, password);

      // Save user data to local storage
      LocalData.setUserLocalData(user);
      LocalData.setLoginLocalData(true);
      isLogin = true;

      emit(UserLoaded(user: user, isLogin: isLogin));
    } catch (e) {
      emit(UserError(message: e));
    }
  }

  /// Load data local to state
  Future<void> loadDataUser() async {
    emit(UserLoading());

    try {
      user = await LocalData.getUserLocalData();
      isLogin = await LocalData.getLoginLocalData();

      // Save user data to local storage
      LocalData.setUserLocalData(user);
      LocalData.setLoginLocalData(true);
      isLogin = true;

      emit(UserLoaded(user: user, isLogin: isLogin));
    } catch (e) {
      emit(UserError(message: e));
    }
  }

  Future<void> getDataLogin() async {
    emit(UserLoading());

    try {
      emit(UserLoaded(user: user, isLogin: isLogin));
    } catch (e) {
      emit(UserError(message: e));
    }
  }

  Future<void> updatePhoto(String userId, String fileName) async {
    await Future.delayed(Duration(seconds: 2));

    try {
      user = await userRepository.updatePhoto(userId, fileName);

      // Save user data to local storage
      LocalData.setUserLocalData(user);

      emit(UserLoaded(user: user, isLogin: isLogin));
    } catch (e) {
      emit(UserError(message: 'Error'));
    }
  }

  Future<void> updateProfile(String userId, String firstName, String lastName,
      String country, String phone, String email) async {
    emit(UserLoading());

    try {
      user = await userRepository.updateProfile(
        userId: userId,
        firstName: firstName,
        lastName: lastName,
        country: country,
        phone: phone,
        email: email,
      );

      // Save user data to local storage
      LocalData.setUserLocalData(user);

      emit(UserLoaded(user: user, isLogin: isLogin));
    } catch (e) {
      print(e.toString());
      emit(UserError(message: 'SHIT'));
    }
  }
}
