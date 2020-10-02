import 'dart:math';

import 'fake_data/fake_comingsoon_data.dart';
import '../data/models/poster_card_model.dart';

abstract class ComingSoonRepository {
  Future<List<PosterCardModel>> fetchComingSoonList(String country);
}

class FakeComingSoonRepository implements ComingSoonRepository {
  @override
  Future<List<PosterCardModel>> fetchComingSoonList(String country) {
    return Future.delayed(Duration(seconds: 2), () {
      final random = Random();

      if (random.nextBool()) {
        throw Exception;
      }

      return FakeComingSoonData.getComingSoonList();
    });
  }
}
