part of 'explore_cubit.dart';

@immutable
abstract class ExploreState {
  const ExploreState();
}

class ExploreInitial extends ExploreState {
  const ExploreInitial();
}

class ExploreLoading extends ExploreState {
  const ExploreLoading();
}

class ExploreLoaded extends ExploreState {
  final List<PosterCardModel> exploreList;

  const ExploreLoaded({this.exploreList});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ExploreLoaded && o.exploreList == exploreList;
  }

  @override
  int get hashCode => exploreList.hashCode;
}

class ExploreError extends ExploreState {
  final String message;

  const ExploreError({this.message});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ExploreError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
