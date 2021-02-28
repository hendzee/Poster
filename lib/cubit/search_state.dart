part of 'search_cubit.dart';

@immutable
abstract class SearchState {
  const SearchState();
}

class SearchInitial extends SearchState {
  const SearchInitial();
}

class SearchLoading extends SearchState {
  const SearchLoading();
}

class SearchError extends SearchState {
  final String message;

  const SearchError({this.message});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SearchError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class SearchLoaded extends SearchState {
  final List<String> sugestions;

  SearchLoaded({this.sugestions});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SearchLoaded && o.sugestions == sugestions;
  }

  @override
  int get hashCode => sugestions.hashCode;
}
