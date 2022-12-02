part of 'auth_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

class AuthenticationInitialState extends AuthenticationState {}

class LoadingState extends AuthenticationState {}

class LogoutSuccessState extends AuthenticationState {}

class LoginSuccessState extends AuthenticationState {
  final User user;

  const LoginSuccessState({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthenticationErrorState extends AuthenticationState {
  final String message;

  const AuthenticationErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
