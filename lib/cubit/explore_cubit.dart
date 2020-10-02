import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/explore_repository.dart';
import '../data/models/poster_card_model.dart';

part 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  final ExploreRepository _exploreRepository;

  ExploreCubit(this._exploreRepository) : super(ExploreInitial());

  Future<void> getExploreList(String country) async {
    try {
      emit(ExploreLoading());
      final exploreList = await _exploreRepository.fetchData(country);
      emit(ExploreLoaded(exploreList: exploreList));
    } catch (_) {
      emit(ExploreError(message: 'Failed to get data explore'));
    }
  }
}
