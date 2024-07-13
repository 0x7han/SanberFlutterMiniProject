import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanber_flutter_mini_project_1/bloc/product/product_bloc.dart';

class ProductDetail extends StatelessWidget {
  final int productId;
  const ProductDetail({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Detail')),
      body: BlocProvider(
        create: (context) =>
            ProductBloc()..add(LoadProductDetail(productId)),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductDetailLoaded) {
              final product = state.product;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.network(
                        product.image,
                        height: 100,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(product.title,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8.0),
                    Text('\$${product.price}', style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 16.0),
                    Text(product.description),
                    const SizedBox(height: 16.0),
                    Text('Category: ${product.category}'),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        const Icon(Icons.star_rate, color: Colors.amber),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          product.rating["rate"].toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '(${product.rating["count"]}) reviews',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 122, 111, 111),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else if (state is ProductErrorState) {
              return Center(
                  child:
                      Text('Failed to load product detail: ${state.message}'));
            }
            return Container();
          },
        ),
      ),
    );
  }
}