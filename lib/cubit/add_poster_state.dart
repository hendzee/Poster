part of 'add_poster_cubit.dart';

@immutable
abstract class AddPosterState {
  const AddPosterState();
}

class AddPosterInitial extends AddPosterState {
  const AddPosterInitial();
}

class AddPosterLoading extends AddPosterState {
  const AddPosterLoading();
}

class AddPosterError extends AddPosterState {
  final String message;

  const AddPosterError({this.message});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddPosterError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class AddPosterLoaded extends AddPosterState {
  final String message;

  const AddPosterLoaded({this.message});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddPosterLoaded && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
