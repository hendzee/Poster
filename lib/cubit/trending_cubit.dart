import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poster/data/trending_repository.dart';

import '../data/models/poster_card_model.dart';

part 'trending_state.dart';

class TrendingCubit extends Cubit<TrendingState> {
  final TrendingRepository _trendingRepository;

  TrendingCubit(this._trendingRepository) : super(TrendingInitial());

  Future<void> getTrending(String country) async {
    try {
      emit(const TrendingLoading());
      final trending = await _trendingRepository.fetchTrending(country);
      emit(TrendingLoaded(posterCardModel: trending));
    } catch (_) {
      emit(const TrendingError(message: 'Failed to get data trending'));
    }
  }
}
