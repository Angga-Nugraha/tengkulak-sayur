import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:tengkulak_sayur/data/utils/utils.dart';
import 'package:tengkulak_sayur/data/utils/routes.dart';
import 'package:tengkulak_sayur/data/utils/common/color.dart';
import 'package:tengkulak_sayur/presentation/bloc/get_all_product_bloc.dart';
import 'package:tengkulak_sayur/presentation/bloc/get_category_product.dart';
import 'package:tengkulak_sayur/presentation/bloc/search_product_bloc.dart';
import 'package:tengkulak_sayur/presentation/pages/root_screen.dart';
import 'package:tengkulak_sayur/presentation/pages/detail_category_page.dart';
import 'package:tengkulak_sayur/presentation/pages/search_page.dart';

import 'injection.dart' as di;

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
        BlocProvider(create: (_) => di.locator<GetAllProductBloc>()),
        BlocProvider(create: (_) => di.locator<SearchProductBloc>()),
        BlocProvider(create: (_) => di.locator<CategoryProductBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const RootScreen(),
        theme: myTheme,
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case searchPageRoute:
              return MaterialPageRoute(
                builder: (_) => const SearchPage(),
              );
            case categoryPageRoute:
              final category = settings.arguments as String;
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
