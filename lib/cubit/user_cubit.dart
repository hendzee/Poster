import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poster/data/user_repository.dart';

import '../data/models/user_model.dart';
import '../modules/local_data.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;

  UserCubit(this._userRepository) : super(UserInitial());

  UserModel _user;

  Future<void> login(String email, String password) async {
    emit(UserLoading());

    try {
      UserModel _user = await _userRepository.login(email, password);

      // Save user data to local storage
      LocalData.setUserLocalData(_user);
      LocalData.setLoginLocalData(true);

      emit(UserLoaded(user: _user));
    } catch (e) {
      emit(UserError(message: e));
    }
  }

  UserModel getUser() {
    return _user;
  }
}
