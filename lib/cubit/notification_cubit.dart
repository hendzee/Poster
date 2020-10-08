import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poster/data/models/notification_card_model.dart';
import 'package:poster/data/notification_repository.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationRepository _notificationRepository;

  NotificationCubit(this._notificationRepository)
      : super(NotificationInitial());

  List<NotificationCardModel> notificationList;

  Future<void> getNotificationList(String userId) async {
    try {
      emit(NotificationLoading());
      notificationList =
          await _notificationRepository.fetchNotificationList(userId);
      emit(NotificationLoaded(notificationList: notificationList));
    } catch (_) {
      emit(NotificationError(message: 'Failed to get data notification.'));
    }
  }

  Future<void> getMoreNotificationList(String userId) async {
    try {
      List<NotificationCardModel> moreNotificationList =
          await _notificationRepository.fetchNotificationList(userId);
      notificationList = notificationList + moreNotificationList;
      emit(NotificationLoaded(notificationList: notificationList));
    } catch (_) {
      emit(NotificationError(message: 'Failed to get data notification.'));
    }
  }
}
