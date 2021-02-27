import 'dart:async';
import '../data/models/notification_card_model.dart';
import '../data/fake_data/fake_notification_data.dart';

abstract class NotificationRepository {
  Future<List<NotificationCardModel>> fetchNotificationList(String userId);
}

class FakeNotificationRepository implements NotificationRepository {
  @override
  Future<List<NotificationCardModel>> fetchNotificationList(String userId) {
    return Future.delayed(Duration(seconds: 1), () {
      return FakeNotificationData.getNotificationList();
    });
  }
}
