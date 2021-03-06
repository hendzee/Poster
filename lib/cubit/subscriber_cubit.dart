import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/subscriber_repository.dart';

part 'subscriber_state.dart';

class SubscriberCubit extends Cubit<SubscriberState> {
  final SubscriberRepository subscriberRepository;

  SubscriberCubit(this.subscriberRepository) : super(SubscriberInitial());

  // Check subscribe status
  Future<void> checkSubscriberStatus(String userId, String posterId) async {
    try {
      emit(SubscriberLoading());

      bool status =
          await subscriberRepository.checkSubscriberStatus(userId, posterId);

      emit(SubscriberLoaded(isSubscribed: status));
    } catch (e) {
      emit(SubscriberError(message: e));
    }
  }

  // Subscriber / unsubscribe
  Future<void> subscribe(String userId, String posterId) async {
    try {
      emit(SubscriberLoading());

      bool status = await subscriberRepository.subscribe(userId, posterId);

      emit(SubscriberLoaded(isSubscribed: status));
    } catch (e) {
      emit(SubscriberError(message: e));
    }
  }
}
