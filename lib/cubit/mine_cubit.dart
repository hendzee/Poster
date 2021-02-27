import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poster/data/mine_repository.dart';
import 'package:poster/data/models/poster_card_model.dart';

part 'mine_state.dart';

class MineCubit extends Cubit<MineState> {
  MineRepository _mineRepository;

  MineCubit(this._mineRepository) : super(MineInitial());

  List<PosterCardModel> mineList;

  int currentPage = 0;
  int lastPage = 0;

  Future<void> getMineList(String userId) async {
    try {
      if (mineList == null || mineList.length < 1) {
        emit(MineLoading());

        currentPage += 1;

        Map<String, dynamic> data =
            await _mineRepository.fetchMineList(userId, currentPage.toString());

        mineList = data['data'];
        currentPage = int.parse(data['currentPage']);
        lastPage = int.parse(data['lastPage']);
      } else {
        currentPage += 1;

        Map<String, dynamic> data =
            await _mineRepository.fetchMineList(userId, currentPage.toString());

        mineList = mineList + data['data'];
        currentPage = int.parse(data['currentPage']);
        lastPage = int.parse(data['lastPage']);
      }
      emit(MineLoaded(mineList: mineList));
    } catch (e) {
      emit(MineError(message: e));
    }
  }
}
