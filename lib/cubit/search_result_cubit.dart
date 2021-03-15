import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poster/data/models/poster_card_model.dart';
import 'package:poster/data/search_result_repository.dart';

part 'search_result_state.dart';

class SearchResultCubit extends Cubit<SearchResultState> {
  SearchResultRepository _searchResultRepository;

  SearchResultCubit(this._searchResultRepository)
      : super(SearchResultInitial());

  List<PosterCardModel> searchResultList;
  int currentPage = 0;
  int lastPage = 0;

  Future<void> fetchSearchResult(String keyword, String country) async {
    try {
      if (searchResultList == null || searchResultList.length < 1) {
        emit(SearchResultLoading());

        currentPage += 1;

        Map<String, dynamic> data = await _searchResultRepository
            .fetchSearchResult(keyword, country, currentPage.toString());

        searchResultList = data['data'];
        currentPage = int.parse(data['currentPage']);
        lastPage = int.parse(data['lastPage']);
      } else {
        currentPage += 1;

        Map<String, dynamic> data = await _searchResultRepository
            .fetchSearchResult(keyword, country, currentPage.toString());

        searchResultList = searchResultList + data['data'];
        currentPage = int.parse(data['currentPage']);
        lastPage = int.parse(data['lastPage']);
      }

      emit(SearchResultLoaded(searchResultList: searchResultList));
    } catch (e) {
      emit(SearchResultError(message: e));
    }
  }
}
