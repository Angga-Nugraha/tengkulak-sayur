import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:tengkulak_sayur/data/utils/utils.dart';
import 'package:tengkulak_sayur/data/utils/routes.dart';
import 'package:tengkulak_sayur/data/utils/common/color.dart';

import 'package:tengkulak_sayur/presentation/bloc/authentication/auth_bloc.dart';
import 'package:tengkulak_sayur/presentation/bloc/user/user_bloc.dart';
import 'package:tengkulak_sayur/presentation/bloc/product/product_bloc.dart';

import 'package:tengkulak_sayur/presentation/pages/auth_page/login_page.dart';
import 'package:tengkulak_sayur/presentation/pages/auth_page/signup_page.dart';
import 'package:tengkulak_sayur/presentation/pages/detail_category_page.dart';
import 'package:tengkulak_sayur/presentation/pages/home_page.dart';
import 'package:tengkulak_sayur/presentation/widgets/bottom_navbar.dart';
import 'package:tengkulak_sayur/presentation/pages/search_page.dart';

import 'package:tengkulak_sayur/presentation/widgets/splash_screen.dart';

import 'injection.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<ProductBloc>()),
        BlocProvider(create: (_) => di.locator<CategoryProductBloc>()),
        BlocProvider(create: (_) => di.locator<SearchProductBloc>()),
        BlocProvider(create: (_) => di.locator<AddUserBloc>()),
        BlocProvider(create: (_) => di.locator<GetUserBloc>()),
        BlocProvider(create: (_) => di.locator<DeleteUserBloc>()),
        BlocProvider(create: (_) => di.locator<LoginBloc>()),
        BlocProvider(create: (_) => di.locator<LogoutBloc>()),
        BlocProvider(create: (_) => di.locator<CheckInLoginBloc>()),
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
              String uuid = settings.arguments as String;
              return MaterialPageRoute(
                builder: (_) => RootScreen(uuid: uuid),
              );
            case searchPageRoute:
              return MaterialPageRoute(
                builder: (_) => const SearchPage(),
              );
            case homePageRoute:
              return MaterialPageRoute(
                builder: (_) => const MyHomePage(),
              );
            case detailCategoryPageRoute:
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
