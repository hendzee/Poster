import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poster/data/mine_repository.dart';
import 'package:poster/data/models/poster_card_model.dart';

part 'mine_state.dart';

class MineCubit extends Cubit<MineState> {
  FakeMineRepository _mineRepository;

  MineCubit(this._mineRepository) : super(MineInitial());

  List<PosterCardModel> mineList;

  Future<void> getMineList(String userId) async {
    try {
      emit(MineLoading());
      mineList = await _mineRepository.fetchMineList(userId);
      emit(MineLoaded(mineList: mineList));
    } catch (_) {
      emit(MineError(message: 'Cant get data mine'));
    }
  }

  Future<void> getMoreMineList(String userId) async {
    try {
      List<PosterCardModel> moreMineList =
          await _mineRepository.fetchMineList(userId);
      mineList = mineList + moreMineList;
      emit(MineLoaded(mineList: mineList));
    } catch (_) {
      emit(MineError(message: 'Cant get data mine'));
    }
  }
}
