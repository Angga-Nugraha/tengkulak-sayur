import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tengkulak_sayur/domain/entities/user.dart';
import 'package:tengkulak_sayur/domain/usecases/auth/signup.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUp signUp;

  SignUpBloc({required this.signUp}) : super(SignUpInitialState()) {
    on<SignUpButtonSubmitted>((event, emit) async {
      final name = event.name;
      final email = event.email;
      final password = event.password;
      final confPassword = event.confPassword;
      final addres = event.addres;
      emit(SignUpLoadingState());

      final auth =
          await signUp.execute(name, email, password, confPassword, addres);
      auth.fold((failure) => emit(SignUpErrorState(message: failure.message)),
          (data) => emit(SignUpSuccessState(result: data)));
    });
  }
}

// Bloc Event
abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
  @override
  List<Object?> get props => [];
}

class SignUpButtonSubmitted extends SignUpEvent {
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

// Bloc State
abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

class SignUpInitialState extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpSuccessState extends SignUpState {
  final User result;

  const SignUpSuccessState({required this.result});

  @override
  List<Object?> get props => [result];
}

class SignUpErrorState extends SignUpState {
  final String message;

  const SignUpErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
