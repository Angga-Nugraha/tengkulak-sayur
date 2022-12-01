import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:tengkulak_sayur/data/utils/utils.dart';
import 'package:tengkulak_sayur/data/utils/routes.dart';
import 'package:tengkulak_sayur/data/utils/common/color.dart';
import 'package:tengkulak_sayur/presentation/authentication/pages/login_page.dart';
import 'package:tengkulak_sayur/presentation/authentication/pages/signup_page.dart';
import 'package:tengkulak_sayur/presentation/bloc/get_all_product_bloc.dart';
import 'package:tengkulak_sayur/presentation/bloc/get_category_product_bloc.dart';
import 'package:tengkulak_sayur/presentation/bloc/search_product_bloc.dart';
import 'package:tengkulak_sayur/presentation/pages/detail_category_page.dart';
import 'package:tengkulak_sayur/presentation/pages/home_page.dart';
import 'package:tengkulak_sayur/presentation/pages/root_screen.dart';
import 'package:tengkulak_sayur/presentation/pages/search_page.dart';
import 'package:tengkulak_sayur/presentation/widgets/splash_screen.dart';

import 'domain/entities/user.dart';
import 'injection.dart' as di;
import 'presentation/authentication/bloc/login_bloc.dart';
import 'presentation/authentication/bloc/profile_me_bloc.dart';
import 'presentation/authentication/bloc/signup_bloc.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<CategoryProductBloc>()),
        BlocProvider(create: (_) => di.locator<GetAllProductBloc>()),
        BlocProvider(create: (_) => di.locator<SearchProductBloc>()),
        BlocProvider(create: (_) => di.locator<ProfileMeBloc>()),
        BlocProvider(create: (_) => di.locator<SignUpBloc>()),
        BlocProvider(create: (_) => di.locator<LoginBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: splashScreenRoute,
        theme: myTheme,
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case splashScreenRoute:
              return MaterialPageRoute(
                builder: (_) => const SplashScreen(),
              );
            case loginPageRoute:
              return MaterialPageRoute(
                builder: (_) => const LoginPage(),
              );
            case signUpPageRoute:
              return MaterialPageRoute(
                builder: (_) => const SignUpPage(),
              );
            case rootScreenRoute:
              User user = settings.arguments as User;
              return MaterialPageRoute(
                builder: (_) => RootScreen(user: user),
              );
            case searchPageRoute:
              return MaterialPageRoute(
                builder: (_) => const SearchPage(),
              );
            case homePageRoute:
              User user = settings.arguments as User;
              return MaterialPageRoute(
                builder: (_) => MyHomePage(user: user),
              );
            case categoryPageRoute:
              String category = settings.arguments as String;
              return MaterialPageRoute(
                builder: (_) => DetailCategory(category: category),
              );
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
