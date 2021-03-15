part of 'search_result_cubit.dart';

@immutable
abstract class SearchResultState {
  const SearchResultState();
}

class SearchResultInitial extends SearchResultState {
  const SearchResultInitial();
}

class SearchResultLoading extends SearchResultState {
  const SearchResultLoading();
}

class SearchResultLoaded extends SearchResultState {
  final List<PosterCardModel> searchResultList;

  const SearchResultLoaded({this.searchResultList});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SearchResultLoaded &&
        other.searchResultList == searchResultList;
  }

  @override
  int get hashCode => searchResultList.hashCode;
}

class SearchResultError extends SearchResultState {
  final String message;

  const SearchResultError({this.message});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SearchResultError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
