import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/router/app_router.dart';
import 'package:movie_app/core/router/app_routes.dart';
import 'package:movie_app/core/utils/theme/app_theme.dart';


class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
            title: 'Movie App',
            theme: darkTheme,
            onGenerateRoute: AppRouter.generateRoute,
            initialRoute: AppRoutes.main,
            builder: (context, widget) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              );
            });
      },
    );
  }
}
