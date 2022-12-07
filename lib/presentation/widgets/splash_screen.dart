import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:tengkulak_sayur/data/database/storageHelper/secure_storage_helper.dart';
import 'package:tengkulak_sayur/data/utils/styles/color.dart';
import 'package:tengkulak_sayur/presentation/bloc/authentication/auth_bloc.dart';
import 'package:tengkulak_sayur/presentation/pages/auth_page/login_page.dart';
import 'package:tengkulak_sayur/presentation/widgets/bottom_navbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          Provider.of<CheckInLoginBloc>(context, listen: false).add(ReLogin()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: foregroundColor,
      body: FutureBuilder(
        initialData: secureStorage.readToken(),
        future: Future.delayed(const Duration(seconds: 5)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                height: 200,
                width: 200,
                child: Lottie.asset('assets/img/splash.json'),
              ),
            );
          } else {
            return BlocBuilder<CheckInLoginBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is LoginSuccessState) {
                  final user = state.user;
                  return RootScreen(uuid: user.uuid!);
                } else {
                  return const LoginPage();
                }
              },
            );
          }
        },
      ),
    );
  }
}
