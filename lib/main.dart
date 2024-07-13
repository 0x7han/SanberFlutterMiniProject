import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanber_flutter_mini_project_1/bloc/cubit/count_cart_cubit.dart';
import 'package:sanber_flutter_mini_project_1/bloc/product/product_bloc.dart';
import 'package:sanber_flutter_mini_project_1/bloc/user/user_bloc.dart';
import 'package:sanber_flutter_mini_project_1/view/screens/product_screen.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ProductBloc>(
        create: (_) => ProductBloc()..add(LoadProducts()),
      ),
      BlocProvider<UserBloc>(
        create: (_) => UserBloc()..add(const LoadUserById(1)),
      ),
      BlocProvider<CountCartCubit>(
        create: (_) => CountCartCubit()..displayTotalQuantity(1),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Project 1 - Team 3',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green, brightness: Brightness.light),
        useMaterial3: true,
      ),
      home: const ProductScreen(),
    );
  }
}
