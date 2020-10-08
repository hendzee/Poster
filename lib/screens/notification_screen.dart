import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/notification_cubit.dart';
import '../data/notification_repository.dart';
import '../widgets/notification_screen/notification_card.dart'; // Substance of notification screen
import '../widgets/notification_screen/notification_list_loading.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationCubit _notificationCubit =
      NotificationCubit(FakeNotificationRepository());
  String _userId = '311210045';
  ScrollController _scrollController = ScrollController();
  int _counter = 0; // Dummy counter to limit scrolling

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _getMoreData();
    });
  }

  void _getMoreData() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll && _counter < 5) {
      _notificationCubit.getMoreNotificationList(_userId);
      this.setState(() {
        _counter += 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
        leading: Container(),
        centerTitle: true,
      ),
      body: BlocProvider(
          create: (context) => _notificationCubit,
          child: BlocConsumer<NotificationCubit, NotificationState>(
            listener: (context, state) {
              if (state is NotificationError) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(state.message),
                ));
              }
            },
            builder: (context, state) {
              if (state is NotificationInitial) {
                _notificationCubit.getNotificationList(_userId);
                return NotificationListLoading();
              } else if (state is NotificationLoading) {
                return NotificationListLoading();
              } else if (state is NotificationLoaded) {
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: _counter < 5
                      ? state.notificationList.length + 1
                      : state.notificationList.length,
                  itemBuilder: (context, index) {
                    if (index < state.notificationList.length) {
                      return NotificationCard(
                        cardModel: state.notificationList[index],
                      );
                    }

                    return Container(
                      width: 30,
                      height: 30,
                      margin: EdgeInsets.all(15),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                );
              } else {
                return NotificationListLoading();
              }
            },
          )),
    );
  }
}
