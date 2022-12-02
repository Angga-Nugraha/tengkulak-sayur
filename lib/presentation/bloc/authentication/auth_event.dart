part of 'auth_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
  @override
  List<Object?> get props => [];
}

class LoginButtonSubmitted extends AuthenticationEvent {
  final String email;
  final String password;

  const LoginButtonSubmitted({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class ReLogin extends AuthenticationEvent {}

class LogoutSubmitted extends AuthenticationEvent {}
