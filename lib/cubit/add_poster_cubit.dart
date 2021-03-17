import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poster/data/add_poster_repository.dart';

part 'add_poster_state.dart';

class AddPosterCubit extends Cubit<AddPosterState> {
  final AddPosterRepository addPosterRepository;

  AddPosterCubit(this.addPosterRepository) : super(AddPosterInitial());

  Future<void> addPoster({
    userId,
    country,
    category,
    title,
    photo,
    description,
    location,
    detailLocation,
    startDate,
    endDate,
    price,
    twitter,
    facebook,
    instagram,
  }) async {
    emit(AddPosterLoading());
    try {
      String status = await addPosterRepository.addPoster(
        userId: userId,
        country: country,
        category: category,
        title: title,
        photo: photo,
        description: description,
        location: location,
        detailLocation: detailLocation,
        startDate: startDate,
        endDate: endDate,
        price: price,
        twitter: twitter,
        facebook: facebook,
        instagram: instagram,
      );
      emit(AddPosterLoaded(message: status));
    } catch (e) {
      emit(AddPosterError(message: 'error nich'));
    }
  }
}
