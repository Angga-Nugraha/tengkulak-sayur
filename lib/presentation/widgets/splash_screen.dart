import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tengkulak_sayur/data/helper/preferences_helper.dart';
import 'package:tengkulak_sayur/data/utils/common/color.dart';
import 'package:tengkulak_sayur/presentation/widgets/start_page.dart';

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
            secureStorage.readToken();
            return Center(
              child: SizedBox(
                height: 200,
                width: 200,
                child: Lottie.asset('assets/img/splash.json'),
              ),
            );
          } else {
            return const StartScreen();
          }
        },
      ),
    );
  }
}
