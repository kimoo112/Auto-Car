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
      body: SizedBox(
        child: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(Assets.imagesYellowSlogan)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                77.verticalSpace,
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
                22.verticalSpace,
                const CustomSignupForm()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
