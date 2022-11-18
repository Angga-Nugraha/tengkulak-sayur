import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tengkulak_sayur/presentation/bloc/get_all_product_bloc.dart';
import 'package:tengkulak_sayur/presentation/pages/root_screen.dart';
import 'injection.dart' as di;
import 'package:tengkulak_sayur/data/utils/color.dart';

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
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const RootScreen(),
          theme: myTheme),
    );
  }
}
