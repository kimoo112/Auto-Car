import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utils/app_colors.dart';
import '../cubit/store_cubit.dart';

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
            return ListView.builder(
              itemCount: 7,
              itemBuilder: (context, index) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  margin: EdgeInsets.all(12.r),
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(15),
                     ),
                  child: ListTile(
                    leading:
                       const Icon(Icons.image_not_supported, size: 80),
                    title: const Text("product.name!"),
                    subtitle: const Text("product.description!"),
                    trailing: Text(
                      "'\$'",
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                    onTap: () {
                      // Handle product tap
                    },
                  ),
                ),
              ),
            );
          } else if (state is GetProductsLoaded) {
            final products = state.products;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Container(
                  margin: EdgeInsets.all(12.r),
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5,
                            spreadRadius: 1,
                            color: AppColors.grey.withOpacity(.4))
                      ]),
                  child: ListTile(
                    leading: product.images!.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              product.images!.first,
                              width: 100,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(Icons.image_not_supported, size: 80),
                    title: Text(product.name!),
                    subtitle: Text(product.description!),
                    trailing: Text(
                      '\$${product.price}',
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                    onTap: () {
                      // Handle product tap
                    },
                  ),
                );
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
