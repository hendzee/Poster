part of 'trending_cubit.dart';

@immutable
abstract class TrendingState {
  const TrendingState();
}

class TrendingInitial extends TrendingState {
  const TrendingInitial();
}

class TrendingLoading extends TrendingState {
  const TrendingLoading();
}

class TrendingLoaded extends TrendingState {
  final PosterCardModel posterCardModel;
  const TrendingLoaded({this.posterCardModel});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TrendingLoaded && o.posterCardModel == posterCardModel;
  }

  @override
  int get hashCode => posterCardModel.hashCode;
}

class TrendingError extends TrendingState {
  final String message;
  const TrendingError({this.message});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TrendingError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
