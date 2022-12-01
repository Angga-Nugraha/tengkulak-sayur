import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tengkulak_sayur/domain/entities/user.dart';
import 'package:tengkulak_sayur/domain/usecases/auth/login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Login login;

  LoginBloc({required this.login}) : super(LoginInitialState()) {
    on<LoginButtonSubmitted>((event, emit) async {
      final email = event.email;
      final password = event.password;

      emit(LoginLoadingState());
      final auth = await login.execute(email, password);
      auth.fold((failure) => emit(LoginErrorState(message: failure.message)),
          (data) => emit(LoginSuccessState(result: data)));
    });
  }
}

// Bloc Event
abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object?> get props => [];
}

class LoginButtonSubmitted extends LoginEvent {
  final String email;
  final String password;

  const LoginButtonSubmitted({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

// Bloc State
abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final User result;

  const LoginSuccessState({required this.result});

  @override
  List<Object?> get props => [result];
}

class LoginErrorState extends LoginState {
  final String message;

  const LoginErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
