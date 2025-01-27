import 'package:auto_car/core/routes/routes.dart';
import 'package:flutter/material.dart';

import '../../../../core/cache/cache_helper.dart';
import '../../../../core/routes/functions/navigation_functions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../data/models/on_boarding_model.dart';

class GetButtons extends StatefulWidget {
  const GetButtons(
      {super.key, required this.currentIndex, required this.controller});
  final int currentIndex;
  final PageController controller;

  @override
  State<GetButtons> createState() => _GetButtonsState();
}

class _GetButtonsState extends State<GetButtons> {
  void onBoardingVisited() {
    CacheHelper.saveData(key: "isOnBoardingVisited", value: true);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.currentIndex == onBoardingData.length - 1) {
      return CustomButton(
        text: ' Get Started',
        textColor: AppColors.white,
        onPressed: () {
          onBoardingVisited();
          customReplacementNavigate(context, loginView);
        },
      );
    } else {
      return Column(
        children: [
          CustomButton(
            text: 'Next',
            textColor: AppColors.white,
            onPressed: () {
              widget.controller.nextPage(
                duration: const Duration(milliseconds: 444),
                curve: Curves.fastLinearToSlowEaseIn,
              );
            },
          ),
        ],
      );
    }
  }
}
