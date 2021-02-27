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

  int currentPage = 0;
  int lastPage = 0;

  Future<void> getSubscriptionList(String userId) async {
    try {
      if (subscriptionList == null || subscriptionList.length < 1) {
        emit(SubscriptionLoading());

        currentPage += 1;

        Map<String, dynamic> data = await _subscriptionRepository
            .fetchSubscriptionList(userId, currentPage.toString());

        subscriptionList = data['data'];
        currentPage = int.parse(data['currentPage']);
        lastPage = int.parse(data['lastPage']);
      } else {
        currentPage += 1;

        Map<String, dynamic> data = await _subscriptionRepository
            .fetchSubscriptionList(userId, currentPage.toString());

        subscriptionList = subscriptionList + data['data'];
        currentPage = int.parse(data['currentPage']);
        lastPage = int.parse(data['lastPage']);
      }

      emit(SubscriptionLoaded(subscriptionList: subscriptionList));
    } catch (_) {
      emit(SubscriptionError(message: 'Cant get data subscription'));
    }
  }
}
