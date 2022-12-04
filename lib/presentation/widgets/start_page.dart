import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tengkulak_sayur/data/storageHelper/secure_storage_helper.dart';
import 'package:tengkulak_sayur/data/utils/routes.dart';
import 'package:tengkulak_sayur/presentation/bloc/authentication/auth_bloc.dart';
import 'package:tengkulak_sayur/presentation/pages/auth_page/login_page.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckInLoginBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          final user = state.user;
          Navigator.pushNamed(context, rootScreenRoute, arguments: user.uuid);
        } else if (state is AuthenticationErrorState) {
          Text(state.message);
        }
      },
      child: FutureBuilder(
        future: secureStorage.readToken(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            context.read<CheckInLoginBloc>().add(ReLogin());
            return const CircularProgressIndicator();
          }
          return const LoginPage();
        },
      ),
    );
  }
}
