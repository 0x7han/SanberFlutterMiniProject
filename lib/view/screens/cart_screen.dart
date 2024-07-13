import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanber_flutter_mini_project_1/bloc/cart/cart_bloc.dart';
import 'package:sanber_flutter_mini_project_1/model/cart.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CartBloc()..add(const LoadCartByUserId(1)), // Pastikan userId benar
      child: Scaffold(
        appBar: AppBar(title: const Text('Cart')),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is LoadingCartState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LoadedCartState) {
              return ListView.builder(
                itemCount: state.carts.length,
                itemBuilder: (context, index) {
                  final cart = state.carts[index];
                  return CartTile(cart: cart);
                },
              );
            } else if (state is CartErrorState) {
              return Center(
                  child: Text('Failed to load cart: ${state.message}'));
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class CartTile extends StatelessWidget {
  final Cart cart;

  const CartTile({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: cart.products.map((cartProduct) {
        return BlocProvider(
          create: (context) =>
              CartBloc()..add(LoadProductById(cartProduct.productId)),
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is LoadingProductState) {
                return const ListTile(title: Text('Loading...'));
              } else if (state is ProductErrorState) {
                return ListTile(title: Text('Error: ${state.message}'));
              } else if (state is LoadedProductState) {
                final product = state.product;
                return ListTile(
                  leading: SizedBox(
                    width: 100,
                    child: Image.network(
                      product.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.category,
                        // style: textTheme.labelMedium!.copyWith(
                        //     color: colorScheme.onSurface.withOpacity(0.5)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        product.title,
                        // style: textTheme.titleMedium!.copyWith(
                        //     color: colorScheme.onSurface.withOpacity(0.7)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  subtitle: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\$ ${product.price}',
                        // style: textTheme.titleMedium!
                        //     .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                          ),
                          Text(
                            product.rating['rate'].toString(),
                            // style: textTheme.labelMedium!.copyWith(
                            //     color:
                            //         colorScheme.onSurface.withOpacity(0.5)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: Icon(
                              Icons.brightness_1,
                              size: 4,
                              // color: colorScheme.onSurface.withOpacity(0.5),
                            ),
                          ),
                          Text(
                            '${product.rating['count'].toString()} sold',
                            // style: textTheme.labelMedium!.copyWith(
                            //     color:
                            //         colorScheme.onSurface.withOpacity(0.5)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(product.title),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.network(product.image),
                              Text('Price: \$${product.price}'),
                              Text('Description: ${product.description}'),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              } else {
                return const ListTile(title: Text('Loading...'));
              }
            },
          ),
        );
      }).toList(),
    );
  }
}
