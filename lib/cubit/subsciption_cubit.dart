import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'subsciption_state.dart';

class SubsciptionCubit extends Cubit<SubsciptionState> {
  SubsciptionCubit() : super(SubsciptionInitial());
}
