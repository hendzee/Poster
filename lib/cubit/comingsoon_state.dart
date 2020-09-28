part of 'comingsoon_cubit.dart';

@immutable
abstract class ComingsoonState {
  const ComingsoonState();
}

class ComingsoonInitial extends ComingsoonState {
  const ComingsoonInitial();
}

class ComingsoonLoading extends ComingsoonState {
  const ComingsoonLoading();
}

class ComingsoonLoaded extends ComingsoonState {
  final List<PosterCardModel> comingSoonList;
  const ComingsoonLoaded({this.comingSoonList});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ComingsoonLoaded && o.comingSoonList == comingSoonList;
  }

  @override
  int get hashCode => comingSoonList.hashCode;
}

class ComingsoonError extends ComingsoonState {
  final String message;
  const ComingsoonError({this.message});
}
