import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tengkulak_sayur/domain/entities/user.dart';
import 'package:tengkulak_sayur/domain/usecases/auth/me.dart';

class ProfileMeBloc extends Bloc<ProfileEvent, ProfileState> {
  final Me me;

  ProfileMeBloc({required this.me}) : super(ProfileInitialState()) {
    on<FetchUser>((event, emit) async {
      final id = event.id;

      emit(ProfileLoadingState());

      final result = await me.execute(id);
      result.fold(
          (failure) => emit(ProfileErrorState(message: failure.message)),
          (data) => emit(ProfileHasDataState(result: data)));
    });
  }
}

// Event Bloc
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class FetchUser extends ProfileEvent {
  final int id;

  const FetchUser({required this.id});

  @override
  List<Object?> get props => [id];
}

// State Bloc
abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileHasDataState extends ProfileState {
  final User result;

  const ProfileHasDataState({required this.result});

  @override
  List<Object?> get props => [result];
}

class ProfileErrorState extends ProfileState {
  final String message;

  const ProfileErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
