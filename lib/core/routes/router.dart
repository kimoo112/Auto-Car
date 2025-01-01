import 'package:auto_car/core/routes/routes.dart';
import 'package:auto_car/core/ui/app_navigation.dart';
import 'package:auto_car/features/auth/presentation/views/login_view.dart';
import 'package:auto_car/features/auth/presentation/views/signup_view.dart';
import 'package:auto_car/features/home/presentation/views/home_view.dart';
import 'package:auto_car/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/splash/splash_view.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashView();
      },
    ),
    GoRoute(
      path: onboarding,
      builder: (BuildContext context, GoRouterState state) {
        return const OnBoardingView();
      },
    ),
    GoRoute(
      path: loginView,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginView();
      },
    ),
    GoRoute(
      path: signupView,
      builder: (BuildContext context, GoRouterState state) {
        return const SignupView();
      },
    ),
    GoRoute(
      path: homeView,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeView();
      },
    ),
     GoRoute(
      path: appNavigation,
      builder: (BuildContext context, GoRouterState state) {
        return const AppNavigation();
      },
    ),
  ],
);