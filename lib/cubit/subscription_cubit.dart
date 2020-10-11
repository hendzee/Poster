import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poster/data/models/poster_card_model.dart';
import 'package:poster/data/subscription_repository.dart';

part 'subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  final SubscriptionRepository _subscriptionRepository;
  SubscriptionCubit(this._subscriptionRepository)
      : super(SubscriptionInitial());

  List<PosterCardModel> subscriptionList;

  Future<void> getSubscriptionList(String userId) async {
    try {
      emit(SubscriptionLoading());
      subscriptionList =
          await _subscriptionRepository.fetchSubscriptionList(userId);
      emit(SubscriptionLoaded(subscriptionList: subscriptionList));
    } catch (_) {
      emit(SubscriptionError(message: 'Cant get data subscription'));
    }
  }

  Future<void> getMoreSubscriptionList(String userId) async {
    try {
      List<PosterCardModel> subscriptionListMore =
          await _subscriptionRepository.fetchSubscriptionList(userId);
      subscriptionList = subscriptionList + subscriptionListMore;
      emit(SubscriptionLoaded(subscriptionList: subscriptionList));
    } catch (_) {
      emit(SubscriptionError(message: 'Cant get data subscription'));
    }
  }
}
