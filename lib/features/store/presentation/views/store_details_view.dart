// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_car/core/routes/functions/navigation_functions.dart';
import 'package:auto_car/core/routes/routes.dart';
import 'package:auto_car/core/widgets/custom_button.dart';
import 'package:auto_car/features/store/data/products_model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/cache/cache_helper.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class StoreDetailsView extends StatelessWidget {
  const StoreDetailsView({
    super.key,
    required this.product,
  });
  final ProductsModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            product.images!.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      product.images!.length == 2
                          ? product.images![1]
                          : product.images!.first,
                      width: double.infinity,
                      height: 250.h,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Icon(Icons.image_not_supported, size: 100),
            12.verticalSpace,
            Text(
              product.name!,
              style: CustomTextStyles.poppins400Style16.copyWith(fontSize: 22),
            ),
            5.verticalSpace,
            Text(
              CacheHelper.getData(key: product.serviceCenterId!) ??
                  "ExxonMobil Station",
              style: CustomTextStyles.poppins400Style12Grey
                  .copyWith(color: AppColors.grey.withOpacity(.6)),
              overflow: TextOverflow.ellipsis,
            ),
            12.verticalSpace,
            Text(
              "Description",
              style: CustomTextStyles.poppins400Style16.copyWith(fontSize: 22),
            ),
            5.verticalSpace,
            Text(
              product.description!,
              style: CustomTextStyles.poppins400Style12Grey
                  .copyWith(color: AppColors.grey.withOpacity(.6)),
            ),
            12.verticalSpace,
            Text(
              "Specification",
              style: CustomTextStyles.poppins400Style16.copyWith(fontSize: 22),
            ),
            5.verticalSpace,
            Text(
              "The currently enabled features require active driver supervision and do not make the vehicle autonomous. The activation and use of these features are dependent on achieving reliability far.",
              style: CustomTextStyles.poppins400Style12Grey
                  .copyWith(color: AppColors.grey.withOpacity(.6)),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Price",
                        style: CustomTextStyles.poppins400Style16
                            .copyWith(fontSize: 12.sp),
                      ),
                      Text(
                        " \$${product.price}",
                        style: CustomTextStyles.poppins400Style16.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: 20.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: CustomButton(
                  marginSize: 0,
                  onPressed: () {
                    customNavigate(context, checkOutView, extra: product);
                  },
                  text: 'BUY NOW',
                  fontSize: 16.sp,
                  textColor: AppColors.white,
                  borderRadius: 12.r,
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
