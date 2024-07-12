import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sanber_flutter_mini_project_1/model/user.dart';
import 'package:sanber_flutter_mini_project_1/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository = UserRepository();

  UserBloc() : super(UserInitial())  {
    on<LoadUserById>((event, emit) async {
      emit(UserLoading());
      try {
        final User user = await _userRepository.getById(event.id);
        emit(UserByIdLoaded(user));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
