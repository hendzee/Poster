part of 'subscriber_cubit.dart';

@immutable
abstract class SubscriberState {
  const SubscriberState();
}

class SubscriberInitial extends SubscriberState {
  const SubscriberInitial();
}

class SubscriberLoading extends SubscriberState {
  const SubscriberLoading();
}

class SubscriberError extends SubscriberState {
  final String message;

  const SubscriberError({this.message});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubscriberError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class SubscriberLoaded extends SubscriberState {
  final isSubscribed;

  const SubscriberLoaded({this.isSubscribed});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubscriberLoaded && other.isSubscribed == isSubscribed;
  }

  @override
  int get hashCode => isSubscribed.hashCode;
}
