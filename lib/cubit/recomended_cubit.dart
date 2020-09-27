import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poster/data/models/poster_card_model.dart';
import 'package:poster/data/recomended_repository.dart';
import 'dart:async';

part 'recomended_state.dart';

class RecomendedCubit extends Cubit<RecomendedState> {
  final RecomendedRepository _recomendedRepository;

  RecomendedCubit(this._recomendedRepository) : super(RecomendedInitial());

  Future<void> getRecomendedList(String country) async {
    try {
      emit(const RecomendedLoading());
      final recomendedList =
          await _recomendedRepository.fetchRecomendedList(country);
      emit(RecomendedLoaded(recomendedList: recomendedList));
    } catch (_) {
      emit(const RecomendedError(message: 'Failed to get recomended'));
    }
  }
}
