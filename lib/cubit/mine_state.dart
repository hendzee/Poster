part of 'mine_cubit.dart';

@immutable
abstract class MineState {
  const MineState();
}

class MineInitial extends MineState {
  const MineInitial();
}

class MineLoading extends MineState {
  const MineLoading();
}

class MineLoaded extends MineState {
  final List<PosterCardModel> mineList;
  const MineLoaded({this.mineList});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MineLoaded && o.mineList == mineList;
  }

  @override
  int get hashCode => mineList.hashCode;
}

class MineError extends MineState {
  final String message;
  const MineError({this.message});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MineError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
