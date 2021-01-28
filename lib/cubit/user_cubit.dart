import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poster/data/user_repository.dart';

import '../data/models/user_model.dart';
import '../modules/local_data.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;
  UserModel _user;
  bool _isLogin;

  UserCubit(this._userRepository) : super(UserInitial());

  /// Input data local when login
  Future<void> login(String email, String password) async {
    emit(UserLoading());

    try {
      _user = await _userRepository.login(email, password);

      // Save user data to local storage
      LocalData.setUserLocalData(_user);
      LocalData.setLoginLocalData(true);
      _isLogin = true;

      emit(UserLoaded(user: _user, isLogin: _isLogin));
    } catch (e) {
      emit(UserError(message: e));
    }
  }

  /// Load data local to state
  Future<void> loadDataUser() async {
    emit(UserLoading());

    try {
      _user = await LocalData.getUserLocalData();
      _isLogin = await LocalData.getLoginLocalData();

      // Save user data to local storage
      LocalData.setUserLocalData(_user);
      LocalData.setLoginLocalData(true);
      _isLogin = true;

      emit(UserLoaded(user: _user, isLogin: _isLogin));
    } catch (e) {
      emit(UserError(message: e));
    }
  }

  Future<void> getDataLogin() async {
    emit(UserLoading());

    try {
      emit(UserLoaded(user: _user, isLogin: _isLogin));
    } catch (e) {
      emit(UserError(message: e));
    }
  }

  Future<void> updatePhoto(String userId, String fileName) async {
    await Future.delayed(Duration(seconds: 2));

    try {
      _user = await _userRepository.updatePhoto(userId, fileName);

      // Save user data to local storage
      LocalData.setUserLocalData(_user);

      emit(UserLoaded(user: _user, isLogin: _isLogin));
    } catch (e) {
      emit(UserError(message: 'Error'));
    }
  }
}
