import 'package:poster/data/fake_data/fake_mine_data.dart';

import '../data/models/poster_card_model.dart';

abstract class MineRepository {
  Future<List<PosterCardModel>> fetchMineList(String userId);
}

class FakeMineRepository implements MineRepository {
  @override
  Future<List<PosterCardModel>> fetchMineList(String userId) {
    return Future.delayed(Duration(seconds: 2), () {
      return FakeMineData.getMineList();
    });
  }
}
