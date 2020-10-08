part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {
  const NotificationState();
}

class NotificationInitial extends NotificationState {
  const NotificationInitial();
}

class NotificationLoading extends NotificationState {
  const NotificationLoading();
}

class NotificationLoaded extends NotificationState {
  final List<NotificationCardModel> notificationList;
  const NotificationLoaded({this.notificationList});
}

class NotificationError extends NotificationState {
  final String message;
  const NotificationError({this.message});
}
