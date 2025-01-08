import '../../../../core/utils/app_assets.dart';

class OnBoardingModel {
  final String imagePath;
  final String subTitle;
  final String title;

  OnBoardingModel({
    required this.imagePath,
    required this.title,
    required this.subTitle,
  });
}

List<OnBoardingModel> onBoardingData = [
  OnBoardingModel(
    imagePath: Assets.imagesOnboarding1,
    title: 'Welcome To Auto Car',
    subTitle: "Your trusted automotive companion.",
  ),
  OnBoardingModel(
    imagePath: Assets.imagesOnboarding2,
    title: 'Find the Best Mechanics',
    subTitle: "Discover top-rated mechanics easily !",
  ),
  OnBoardingModel(
    imagePath: Assets.imagesOnboarding3,
    title: 'Find Nearby ',
    subTitle: "Find mechanics and stations on the map !",
  ),
];
