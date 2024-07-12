import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanber_flutter_mini_project_1/bloc/cart/cart_bloc.dart';
import 'package:sanber_flutter_mini_project_1/model/cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: BlocBuilder<CartBloc, CartState>(builder: (_, state) {
        if (state is CartLoaded) {
          final List<Cart> carts = state.carts;
          return ListView.builder(
            itemCount: carts.length,
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(carts[index].date),
                subtitle: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 200,
                  ),
                  child: ListView.builder(
                    itemCount: carts[index].products.length,
                    itemBuilder: (_, i) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              carts[index].products[i]['productId'].toString()),
                          Text(carts[index].products[i]['quantity'].toString()),
                        ],
                      );
                    },
                  ),
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
