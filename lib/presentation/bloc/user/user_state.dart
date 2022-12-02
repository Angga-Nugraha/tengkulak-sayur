part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserSuccessState extends UserState {}

class SetUserState extends UserState {
  final User result;

  const SetUserState({required this.result});

  @override
  List<Object?> get props => [result];
}

class UserErrorState extends UserState {
  final String message;

  const UserErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
