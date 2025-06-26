import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/utils/icons/app_icons.dart';
import 'package:movie_app/core/utils/theme/app_theme.dart';
import 'package:movie_app/features/favorites/presentation/screens/favorite_screen.dart';
import 'package:movie_app/features/home/presentation/bloc/trending_cubit.dart';
import 'package:movie_app/features/home/presentation/bloc/upcoming_cubit.dart';
import 'package:movie_app/features/home/presentation/screens/home_screen.dart';

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
            home: const MovieAppMainScreen(),
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

class MovieAppMainScreen extends StatefulWidget {
  const MovieAppMainScreen({super.key});

  @override
  State<MovieAppMainScreen> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieAppMainScreen> {
  List<Widget> pages = [
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TrendingCubit(),
        ),
        BlocProvider(
          create: (context) => UpcomingCubit(),
        ),
      ],
      child: const HomeScreen(),
    ),
    const FavoriteScreen(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
            leading: IconButton(
              onPressed: () {
                //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Categories()));
              },
              icon: const Icon(
                Icons.grid_view_rounded,
                color: Colors.white,
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 15),
                child: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://img.freepik.com/premium-photo/young-man-isolated-blue_1368-124991.jpg?semt=ais_hybrid&w=740"),
                ),
              )
            ],
            elevation: 0.0,
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer),
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.white,
        selectedLabelStyle: Theme.of(context).textTheme.bodySmall,
        unselectedLabelStyle: Theme.of(context).textTheme.bodySmall,
        currentIndex: currentIndex,
        elevation: 0.0,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: AppIcons.home(
                  color: currentIndex == 0
                      ? Theme.of(context).colorScheme.primary
                      : Colors.white),
              label: "Home"),
          BottomNavigationBarItem(
              icon: AppIcons.favorite(
                  color: currentIndex == 1
                      ? Theme.of(context).colorScheme.primary
                      : Colors.white),
              label: "Favorites"),
        ],
      ),
    );
  }
}
