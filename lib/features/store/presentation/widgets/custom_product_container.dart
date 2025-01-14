import 'package:auto_car/core/routes/functions/navigation_functions.dart';
import 'package:auto_car/core/routes/routes.dart';
import 'package:auto_car/core/utils/app_text_styles.dart';
import 'package:auto_car/features/store/data/products_model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/cache/cache_helper.dart';
import '../../../../core/utils/app_colors.dart';

class CustomProductContainer extends StatelessWidget {
  const CustomProductContainer({
    super.key,
    required this.product,
  });

  final ProductsModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        customNavigate(context, storeDetailsView, extra: product);
      },
      child: Container(
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            product.images!.isNotEmpty
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
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    product.description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: AppColors.dark.withOpacity(.6),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        IconlyBold.location,
                        color: AppColors.primaryColor,
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          CacheHelper.getData(key: product.serviceCenterId!) ??
                              "ExxonMobil Station",
                          style: CustomTextStyles.poppins400Style12Grey,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              '\$${product.price}',
              style: TextStyle(
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
