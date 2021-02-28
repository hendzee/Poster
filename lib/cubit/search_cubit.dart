import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poster/data/search_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchRepository _searchRepository;

  SearchCubit(this._searchRepository) : super(SearchInitial());

  List<String> sugestions;

  Future<void> fetchSugestionList(String keyword) async {
    emit(SearchLoading());

    try {
      sugestions = await _searchRepository.fetchSugestionList(keyword);

      emit(SearchLoaded(sugestions: sugestions));
    } catch (e) {
      emit(SearchError(message: e));
    }
  }
}
