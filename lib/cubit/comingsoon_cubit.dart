import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poster/data/comingsoon_repository.dart';

import '../data/models/poster_card_model.dart';

part 'comingsoon_state.dart';

class ComingsoonCubit extends Cubit<ComingsoonState> {
  final FakeComingSoonRepository _fakeComingSoonRepository;

  ComingsoonCubit(this._fakeComingSoonRepository) : super(ComingsoonInitial());

  Future<void> getComingSoonList(String country) async {
    try {
      emit(ComingsoonLoading());
      final comingSoonList =
          await _fakeComingSoonRepository.fetchComingSoonList(country);
      emit(ComingsoonLoaded(comingSoonList: comingSoonList));
    } catch (_) {
      emit(ComingsoonError(message: 'Fail to get data coming soon'));
    }
  }
}
