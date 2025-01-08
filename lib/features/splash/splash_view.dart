import 'package:auto_car/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/api/end_points.dart';
import '../../core/cache/cache_helper.dart';
import '../../core/routes/functions/navigation_functions.dart';
import '../../core/routes/routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _checkTokenAndNavigate();
  }

  void _checkTokenAndNavigate() async {
    final token = await CacheHelper.getSecuredString(key: ApiKeys.token);
    debugPrint('Token: $token');
    if (!mounted) return;
    delayedNavigate(
      context,
      token != '' ? appNavigation : onboarding,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Image.asset(
          Assets.imagesLogo,
          width: 240.w,
          height: 210.h,
        ),
      ),
    );
  }
}
