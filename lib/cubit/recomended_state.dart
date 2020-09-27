part of 'recomended_cubit.dart';

@immutable
abstract class RecomendedState {
  const RecomendedState();
}

class RecomendedInitial extends RecomendedState {
  const RecomendedInitial();
}

class RecomendedLoading extends RecomendedState {
  const RecomendedLoading();
}

class RecomendedLoaded extends RecomendedState {
  final List<PosterCardModel> recomendedList;
  const RecomendedLoaded({this.recomendedList});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RecomendedLoaded && o.recomendedList == recomendedList;
  }

  @override
  int get hashCode => recomendedList.hashCode;
}

class RecomendedError extends RecomendedState {
  final String message;
  const RecomendedError({this.message});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RecomendedError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
