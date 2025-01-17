import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../widgets/custom_login_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          10.verticalSpace,
          Image.asset(Assets.imagesYellowSlogan),
          40.verticalSpace,
          _buildLoginTitle(),
          22.verticalSpace,
          const CustomLoginForm()
        ],
      ),
    );
  }

  Column _buildLoginTitle() {
    return Column(
      children: [
        Text(
          'Welcome Back 👋',
          style: CustomTextStyles.poppins400Style24,
        ),
        10.verticalSpace,
        Text(
          'Hi there, you’ve been missed',
          style: CustomTextStyles.poppins400Style14
              .copyWith(color: AppColors.grey),
        ),
      ],
    );
  }
}
