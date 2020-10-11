import 'package:poster/data/fake_data/fake_mine_data.dart';
import 'package:poster/data/fake_data/fake_subscription_data.dart';

import '../data/models/poster_card_model.dart';

abstract class SubscriptionRepository {
  Future<List<PosterCardModel>> fetchSubscriptionList(String userId);
}

class FakeSubscriptionRepository implements SubscriptionRepository {
  @override
  Future<List<PosterCardModel>> fetchSubscriptionList(String userId) {
    return Future.delayed(Duration(seconds: 2), () {
      return FakeSubscriptionData.getSubscriptionList();
    });
  }
}
