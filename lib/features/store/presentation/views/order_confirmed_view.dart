import 'dart:math';

import 'package:auto_car/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/routes/functions/navigation_functions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class OrderConfirmedView extends StatefulWidget {
  const OrderConfirmedView({super.key});

  @override
  State<OrderConfirmedView> createState() => _OrderConfirmedViewState();
}

class _OrderConfirmedViewState extends State<OrderConfirmedView> {
  // Generate Random 8-Digit Order ID
  final String orderId = _generateOrderId();

  static String _generateOrderId() {
    final Random random = Random();
    int number =
        random.nextInt(90000000) + 10000000; // Generates 8-digit number
    return number.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                Assets.imagesDoneYellow,
              ),
              Text(
                'Order Confirmed!',
                style: CustomTextStyles.poppins400Style24
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              Text(
                  'Thank you for your purchase.\nYour order will be processed soon.',
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.poppins400Style16Grey
                      .copyWith(fontSize: 14.sp)),
              const SizedBox(height: 30),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text('Order ID: #$orderId',
                    style: CustomTextStyles.poppins400Style14),
              ),
              20.verticalSpace,
              CustomButton(
                text: 'RETURN TO HOME',
                borderRadius: 10,
                fontSize: 12.sp,
                onPressed: () {
                  customReplacementAndRemove(context, appNavigation);
                },
                textColor: AppColors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
