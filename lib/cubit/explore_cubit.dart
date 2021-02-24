import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/explore_repository.dart';
import '../data/models/poster_card_model.dart';

part 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  final ExploreRepository _exploreRepository;
  List<PosterCardModel> exploreList;

  ExploreCubit(this._exploreRepository) : super(ExploreInitial());

  int currentPage = 0;
  int lastPage = 0;

  // Get initial data explore list for first time
  Future<void> getExploreList(String country) async {
    try {
      if (exploreList == null || exploreList.length < 1) {
        emit(ExploreLoading());

        currentPage += 1;

        Map<String, dynamic> data =
            await _exploreRepository.fetchData(country, currentPage.toString());

        exploreList = data['data'];
        currentPage = int.parse(data['currentPage']);
        lastPage = int.parse(data['lastPage']);
      } else {
        currentPage += 1;

        Map<String, dynamic> data =
            await _exploreRepository.fetchData(country, currentPage.toString());

        exploreList = exploreList + data['data'];
        currentPage = int.parse(data['currentPage']);
        lastPage = int.parse(data['lastPage']);
      }

      emit(ExploreLoaded(exploreList: exploreList));
    } catch (e) {
      emit(
        ExploreError(message: e),
      );
    }
  }
}
