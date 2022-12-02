import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tengkulak_sayur/domain/entities/user.dart';
import 'package:tengkulak_sayur/domain/usecases/user/add_user.dart';
import 'package:tengkulak_sayur/domain/usecases/user/get_user_by_id.dart';

part 'user_event.dart';
part 'user_state.dart';

class AddUserBloc extends Bloc<UserEvent, UserState> {
  final SignUp signUp;

  AddUserBloc({required this.signUp}) : super(UserInitialState()) {
    on<SignUpButtonSubmitted>((event, emit) async {
      final name = event.name;
      final email = event.email;
      final password = event.password;
      final confPassword = event.confPassword;
      final addres = event.addres;
      emit(UserLoadingState());

      final auth =
          await signUp.execute(name, email, password, confPassword, addres);
      auth.fold(
        (failure) => emit(UserErrorState(message: failure.message)),
        (data) => emit(UserSuccessState()),
      );
    });
  }
}

class GetUserBloc extends Bloc<UserEvent, UserState> {
  GetUserById getUserById;

  GetUserBloc({required this.getUserById}) : super(UserInitialState()) {
    on<SetUserById>((event, emit) async {
      final id = event.uuid;

      emit(UserLoadingState());

      final user = await getUserById.execute(id);
      user.fold(
        (failure) => emit(UserErrorState(message: failure.message)),
        (data) => emit(SetUserState(result: data)),
      );
    });
  }
}
