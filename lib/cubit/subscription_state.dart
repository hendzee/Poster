part of 'subscription_cubit.dart';

@immutable
abstract class SubscriptionState {
  const SubscriptionState();
}

class SubscriptionInitial extends SubscriptionState {
  const SubscriptionInitial();
}

class SubscriptionLoading extends SubscriptionState {
  const SubscriptionLoading();
}

class SubscriptionLoaded extends SubscriptionState {
  final List<PosterCardModel> subscriptionList;
  const SubscriptionLoaded({this.subscriptionList});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SubscriptionLoaded && o.subscriptionList == subscriptionList;
  }

  @override
  int get hashCode => subscriptionList.hashCode;
}

class SubscriptionError extends SubscriptionState {
  final String message;
  const SubscriptionError({this.message});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SubscriptionError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
