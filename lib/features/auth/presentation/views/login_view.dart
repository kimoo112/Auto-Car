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
                22.verticalSpace,
                const CustomLoginForm()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
