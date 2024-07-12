part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUsers extends UserEvent{}

class LoadUserById extends UserEvent{
  final int id;

  const LoadUserById(this.id);

  @override
  List<Object> get props => [id];
}
