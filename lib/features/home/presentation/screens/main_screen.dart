import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/firebase/firebase_service.dart';
import 'package:movie_app/core/services/service_locator.dart';
import 'package:movie_app/core/utils/icons/app_icons.dart';
import 'package:movie_app/features/favorites/presentation/screens/favorite_screen.dart';
import 'package:movie_app/features/home/presentation/bloc/trending_cubit.dart';
import 'package:movie_app/features/home/presentation/bloc/trending_people_cubit.dart';
import 'package:movie_app/features/home/presentation/bloc/upcoming_cubit.dart';
import 'package:movie_app/features/home/presentation/screens/home_screen.dart';

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
          create: (context) => getIt<TrendingCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<UpcomingCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<TrendingPeopleCubit>(),
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
            actions: [
              Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: const CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/images/logo.png"), // أو NetworkImage
                  ))
            ],
            elevation: 0.0,
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer),
      ),
      drawer: MovieDrawer(
        onLogout: () {
          // Sign out the user and clear cache
          FirebaseService.signOut();
          // Clear the service locator
          getIt.reset();
          // Navigate to the login screen
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/signIn',
            (route) => false,
          );
        },
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

class MovieDrawer extends StatelessWidget {
  final VoidCallback onLogout;

  const MovieDrawer({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/logo.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: null,
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Search'),
            onTap: () => Navigator.pushNamed(context, '/searchScreen'),
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Log out', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              onLogout();
            },
          ),
        ],
      ),
    );
  }
}
