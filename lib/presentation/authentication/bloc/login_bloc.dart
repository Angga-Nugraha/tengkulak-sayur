import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tengkulak_sayur/domain/entities/user.dart';
import 'package:tengkulak_sayur/domain/repositories/auth_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(const LoginState()) {
    on<LoginSubmitted>((event, emit) async {
      final email = event.email;
      final password = event.password;

      final result = await authRepository.login(email, password);
      result.fold(
        (failure) => emit(FormSubmitted()),
        (data) => emit(SubmittedSuccess(data)),
      );
    });
  }
}

// Bloc Event
abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;

  const LoginSubmitted({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

// Bloc State
class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class FormSubmitted extends LoginState {}

class SubmittedSuccess extends LoginState {
  final User user;
  const SubmittedSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class SubmittedFailed extends LoginState {
  final String message;

  const SubmittedFailed({required this.message});

  @override
  List<Object?> get props => [message];
}
