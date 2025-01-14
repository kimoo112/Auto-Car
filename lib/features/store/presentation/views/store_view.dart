import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/store_cubit.dart';
import '../widgets/custom_product_container.dart';
import '../widgets/custom_products_shimmer.dart';

class StoreView extends StatelessWidget {
  const StoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store'),
        centerTitle: true,
      ),
      body: BlocBuilder<StoreCubit, StoreState>(
        builder: (context, state) {
          if (state is GetProductsLoading) {
            return const CustomProductsShimmer();
          } else if (state is GetProductsLoaded) {
            final products = state.products;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return CustomProductContainer(product: product);
              },
            );
          } else if (state is GetProductsFailure) {
            return Center(
              child: Text(
                state.errMessage,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
