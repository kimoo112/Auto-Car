import 'package:auto_car/core/api/dio_consumer.dart';
import 'package:auto_car/core/cache/cache_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routes/router.dart';
import 'core/utils/bloc_observer.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper.init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  Bloc.observer = MyBlocObserver();
  runApp(const AutoCar());
}

class AutoCar extends StatelessWidget {
  const AutoCar({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return BlocProvider(
            create: (context) => AuthCubit(DioConsumer(dio: Dio())),
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Auto Car',
              theme: ThemeData(
                useMaterial3: true,
                textTheme: Theme.of(context).textTheme.apply(
                      fontFamily: 'Poppins',
                    ),
              ),
              routerConfig: router,
            ),
          );
        });
  }
}
