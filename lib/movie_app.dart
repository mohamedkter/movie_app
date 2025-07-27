import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
        return FutureBuilder<User?>(
          future: _checkUserLoggedIn(),
          builder: (context, snapshot) {
            // Waiting for Firebase to check user state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // If there's an error
            if (snapshot.hasError) {
              return const MaterialApp(
                home: Scaffold(body: Center(child: Text("Error loading app"))),
              );
            }

            // Determine initial route
            final bool isLoggedIn = snapshot.data != null;
            final String initialRoute = isLoggedIn ? AppRoutes.main : AppRoutes.signIn;

            return MaterialApp(
              title: 'Movie App',
              theme: darkTheme,
              onGenerateRoute: AppRouter.generateRoute,
              initialRoute: initialRoute,
              builder: (context, widget) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: widget!,
                );
              },
            );
          },
        );
      },
    );
  }

  Future<User?> _checkUserLoggedIn() async {
    // This ensures Firebase is initialized before checking user
    await Future.delayed(Duration.zero); // remove if already initialized elsewhere
    return FirebaseAuth.instance.currentUser;
  }
}
