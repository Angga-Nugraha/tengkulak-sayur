import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tengkulak_sayur/data/utils/common/color.dart';
import 'package:tengkulak_sayur/presentation/authentication/pages/login_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: foregroundColor,
      body: FutureBuilder(
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
              return const LoginPage();
            }
          }),
    );
  }
}
