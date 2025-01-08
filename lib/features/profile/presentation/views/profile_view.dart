import 'package:auto_car/core/api/end_points.dart';
import 'package:auto_car/core/cache/cache_helper.dart';
import 'package:auto_car/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    color: AppColors.primaryColor,
                    width: double.infinity,
                    height: 160.h,
                  ),
                  Positioned(
                      bottom: -20.h,
                      right: 0,
                      left: 0,
                      child: CircleAvatar(
                        minRadius: 40.h,
                      ))
                ],
              ),
              20.verticalSpace,
              Text(
                CacheHelper.getData(key: ApiKeys.name),
                style: CustomTextStyles.poppins400Style16,
              ),
              Text(
                CacheHelper.getData(key: ApiKeys.email),
                style: CustomTextStyles.poppins400Style12Grey,
              ),
              ListTile(
                leading:
                    Icon(IconlyLight.profile, color: AppColors.primaryColor),
                title: const Text('Personal Information'),
                trailing: Icon(
                  IconlyBroken.arrowRight2,
                  color: AppColors.primaryColor,
                ),
              ),
              ListTile(
                leading: Icon(IconlyLight.plus, color: AppColors.primaryColor),
                title: const Text('Payment Methods'),
                trailing: Icon(
                  IconlyBroken.arrowRight2,
                  color: AppColors.primaryColor,
                ),
              ),
              ListTile(
                leading: Icon(IconlyLight.notification,
                    color: AppColors.primaryColor),
                title: const Text('Notifications'),
                trailing: Icon(
                  //todo add switch here
                  IconlyBroken.arrowRight2,
                  color: AppColors.primaryColor,
                ),
              ),
              ListTile(
                leading: Icon(IconlyLight.chat, color: AppColors.primaryColor),
                title: const Text('Feedback and support'),
                trailing: Icon(
                  IconlyBroken.arrowRight2,
                  color: AppColors.primaryColor,
                ),
              ),
              ListTile(
                leading:
                    Icon(IconlyLight.infoSquare, color: AppColors.primaryColor),
                title: const Text('About the app'),
                trailing: Icon(
                  IconlyBroken.arrowRight2,
                  color: AppColors.primaryColor,
                ),
              ),
              ListTile(
                leading:
                    Icon(IconlyLight.logout, color: AppColors.primaryColor),
                title: const Text('Logout'),
                trailing: Icon(
                  IconlyBroken.arrowRight2,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          Positioned(
            child: Image.asset(
              Assets.imagesVectors,
            ),
          ),
        ],
      ),
    );
  }
}
