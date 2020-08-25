import 'package:flutter/material.dart';
import 'package:poster/models/notification_card_model.dart';
import '../widgets/notification_screen/notification_card.dart'; // Substance of notification screen

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationCardModel dummyData = NotificationCardModel(
    id: '1',
    title: 'Mega Purple Concert 2020',
    image: 'assets/dummy_images/poster1.png',
    eventTime: 'Even begin in 3 hours',
    notifTime: '28 Aug, 2020 7:52 PM',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
        leading: Container(),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NotificationCard(cardModel: this.dummyData,)
          ],
        ),
      ),
    );
  }
}
