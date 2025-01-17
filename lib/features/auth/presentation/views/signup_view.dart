import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../widgets/custom_signup_form.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          10.verticalSpace,
          Image.asset(Assets.imagesYellowSlogan),
          77.verticalSpace,
          _buildSignupTitle(),
          22.verticalSpace,
          const CustomSignupForm()
        ],
      ),
    );
  }

  Column _buildSignupTitle() {
    return Column(
      children: [
        Text(
          'Join Auto Car Now !',
          style: CustomTextStyles.poppins400Style24,
        ),
        10.verticalSpace,
        Text(
          'Sign up to connect with nearby mechanics and stations in seconds. ',
          style: CustomTextStyles.poppins400Style14
              .copyWith(color: AppColors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
