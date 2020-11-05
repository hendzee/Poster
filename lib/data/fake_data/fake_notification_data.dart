import '../../data/models/notification_card_model.dart';

class FakeNotificationData {
  static final List<NotificationCardModel> notificationList = [
    NotificationCardModel(
      id: '1',
      title: 'Mega Purple Concert 2020',
      image: 'assets/dummy_images/poster2.png',
      eventTime: 'Even begin in 3 hours',
      notifTime: '28 Aug, 2020 7:52 PM',
    ),
    NotificationCardModel(
      id: '1',
      title: 'Mega Purple Concert 2020',
      image: 'assets/dummy_images/poster3.png',
      eventTime: 'Even begin in 3 hours',
      notifTime: '28 Aug, 2020 7:52 PM',
    ),
    NotificationCardModel(
      id: '1',
      title: 'Mega Purple Concert 2020',
      image: 'assets/dummy_images/poster5.png',
      eventTime: 'Even begin in 3 hours',
      notifTime: '28 Aug, 2020 7:52 PM',
    ),
    NotificationCardModel(
      id: '1',
      title: 'Mega Purple Concert 2020',
      image: 'assets/dummy_images/poster1.png',
      eventTime: 'Even begin in 3 hours',
      notifTime: '28 Aug, 2020 7:52 PM',
    ),
    NotificationCardModel(
      id: '1',
      title: 'Mega Purple Concert 2020',
      image: 'assets/dummy_images/poster4.png',
      eventTime: 'Even begin in 3 hours',
      notifTime: '28 Aug, 2020 7:52 PM',
    ),
    NotificationCardModel(
      id: '1',
      title: 'Mega Purple Concert 2020',
      image: 'assets/dummy_images/poster7.png',
      eventTime: 'Even begin in 3 hours',
      notifTime: '28 Aug, 2020 7:52 PM',
    ),
    NotificationCardModel(
      id: '1',
      title: 'Mega Purple Concert 2020',
      image: 'assets/dummy_images/poster3.png',
      eventTime: 'Even begin in 3 hours',
      notifTime: '28 Aug, 2020 7:52 PM',
    ),
  ];

  static List<NotificationCardModel> getNotificationList() {
    return notificationList;
  }
}
