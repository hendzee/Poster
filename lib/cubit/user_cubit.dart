import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poster/data/user_repository.dart';

import '../data/models/user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;

  UserCubit(this._userRepository) : super(UserInitial());

  Future<void> login(String email, String password) async {
    emit(UserLoading());

    try {
      UserModel user = await _userRepository.login(email, password);

      emit(UserLoaded(user: user));
    } catch (e) {
      emit(UserError(message: e));
    }
  }
}
