import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/explore_repository.dart';
import '../data/models/poster_card_model.dart';

part 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  final ExploreRepository _exploreRepository;
  List<PosterCardModel> exploreList;

  ExploreCubit(this._exploreRepository) : super(ExploreInitial());

  // Get initial data explore list for first time
  Future<void> getExploreList(String country) async {
    try {
      emit(ExploreLoading());
      exploreList = await _exploreRepository.fetchData(country);
      emit(ExploreLoaded(exploreList: exploreList));
    } catch (_) {
      emit(ExploreError(message: 'Failed to get data explorer'));
    }
  }

  // Get more more data explore list
  Future<void> getMoreExploreList(String country) async {
    try {
      List<PosterCardModel> moreExploreList =
          await _exploreRepository.fetchData(country);
      exploreList = exploreList + moreExploreList;
      emit(ExploreLoaded(exploreList: exploreList));
    } catch (_) {
      emit(ExploreError(message: 'Failed to get data expolorer'));
    }
  }
}
