part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
  @override
  List<Object?> get props => [];
}

class SignUpButtonSubmitted extends UserEvent {
  final String name;
  final String email;
  final String password;
  final String confPassword;
  final String addres;

  const SignUpButtonSubmitted(
      {required this.name,
      required this.email,
      required this.password,
      required this.confPassword,
      required this.addres});

  @override
  List<Object?> get props => [name, email, password, confPassword, addres];
}

class SetUserById extends UserEvent {
  final String uuid;

  const SetUserById({required this.uuid});

  @override
  List<Object?> get props => [uuid];
}
