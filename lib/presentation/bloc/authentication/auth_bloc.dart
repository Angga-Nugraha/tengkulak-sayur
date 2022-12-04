import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tengkulak_sayur/data/storageHelper/secure_storage_helper.dart';
import 'package:tengkulak_sayur/domain/entities/user.dart';
import 'package:tengkulak_sayur/domain/usecases/auth/login.dart';
import 'package:tengkulak_sayur/domain/usecases/auth/logout.dart';
import 'package:tengkulak_sayur/domain/usecases/user/get_user_by_id.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class LoginBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final Login login;

  LoginBloc({required this.login}) : super(AuthenticationInitialState()) {
    on<LoginButtonSubmitted>(
      (event, emit) async {
        final email = event.email;
        final password = event.password;

        emit(LoadingState());
        final auth = await login.execute(email, password);

        auth.fold(
          (failure) {
            emit(AuthenticationErrorState(message: failure.message));
          },
          (data) {
            emit(LoginSuccessState(user: data));
          },
        );
      },
    );
  }
}

class CheckInLoginBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  GetUserById getUserById;

  CheckInLoginBloc({required this.getUserById})
      : super(AuthenticationInitialState()) {
    on<ReLogin>((event, emit) async {
      final uuid = await secureStorage.readId();

      final auth = await getUserById.execute(uuid!);
      auth.fold(
          (failure) => emit(AuthenticationErrorState(message: failure.message)),
          (data) => emit(LoginSuccessState(user: data)));
    });
  }
}

class LogoutBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  Logout logout;

  LogoutBloc({required this.logout}) : super(AuthenticationInitialState()) {
    on<LogoutSubmitted>((event, emit) async {
      emit(LoadingState());
      await logout.execute();
      emit(LogoutSuccessState());
    });
  }
}
