import 'package:auto_car/core/utils/app_colors.dart';
import 'package:auto_car/features/home/presentation/views/home_view.dart';
import 'package:auto_car/features/store/presentation/views/store_view.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../features/profile/presentation/views/profile_view.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeView(),
    const StoreView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_currentIndex],
      bottomNavigationBar: FloatingNavbar(
        backgroundColor: AppColors.white,
        iconSize: 22,
        elevation: 8,
        itemBorderRadius: 50,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.dark,
        borderRadius: 30.0,
        items: [
          FloatingNavbarItem(
            icon: IconlyBroken.home,
          ),
          FloatingNavbarItem(
            icon: IconlyBroken.buy,
          ),
          FloatingNavbarItem(
            icon: IconlyBroken.profile,
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
