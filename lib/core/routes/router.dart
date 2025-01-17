import 'package:auto_car/core/routes/routes.dart';
import 'package:auto_car/core/ui/app_navigation.dart';
import 'package:auto_car/features/auth/presentation/views/login_view.dart';
import 'package:auto_car/features/auth/presentation/views/signup_view.dart';
import 'package:auto_car/features/home/presentation/views/home_view.dart';
import 'package:auto_car/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:auto_car/features/profile/presentation/views/profile_view.dart';
import 'package:auto_car/features/store/data/products_model/products_model.dart';
import 'package:auto_car/features/store/presentation/cubit/store_cubit.dart';
import 'package:auto_car/features/store/presentation/views/checkout_view.dart';
import 'package:auto_car/features/store/presentation/views/store_details_view.dart';
import 'package:auto_car/features/store/presentation/views/store_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/profile/presentation/views/card_view.dart';
import '../../features/splash/splash_view.dart';
import '../../features/store/presentation/views/order_confirmed_view.dart';
import '../api/dio_consumer.dart';

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
      path: appNavigation,
      builder: (BuildContext context, GoRouterState state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => HomeCubit(DioConsumer(dio: Dio()))
                ..getLocation()
                ..getServicesCenters(),
            ),
            BlocProvider(
              create: (context) =>
                  StoreCubit(DioConsumer(dio: Dio()))..getProducts(),
            )
          ],
          child: const AppNavigation(),
        );
      },
    ),
    GoRoute(
      path: homeView,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeView();
      },
    ),
    GoRoute(
      path: storeView,
      builder: (BuildContext context, GoRouterState state) {
        return const StoreView();
      },
    ),
    GoRoute(
      path: storeDetailsView,
      builder: (BuildContext context, GoRouterState state) {
        final product = state.extra as ProductsModel;
        return StoreDetailsView(
          product: product,
        );
      },
    ),
    GoRoute(
      path: checkOutView,
      builder: (BuildContext context, GoRouterState state) {
        final product = state.extra as ProductsModel;
        return CheckoutDetailsScreen(
          product: product,
        );
      },
    ),
    GoRoute(
      path: orderConfirmedView,
      builder: (BuildContext context, GoRouterState state) {
        return const OrderConfirmedView();
      },
    ),
    GoRoute(
      path: profileView,
      builder: (BuildContext context, GoRouterState state) {
        return const ProfileView();
      },
    ),
    GoRoute(
      path: cardView,
      builder: (BuildContext context, GoRouterState state) {
        return const CardView();
      },
    ),
  ],
);
