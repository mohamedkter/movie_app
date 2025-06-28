import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/router/app_routes.dart';
import 'package:movie_app/features/details/ui/bloc/movie_details_cubit.dart';
import 'package:movie_app/features/details/ui/bloc/recommended_movies_cubit.dart';
import 'package:movie_app/features/details/ui/bloc/similar_movies_cubit.dart';
import 'package:movie_app/features/details/ui/screen/details_screen.dart';
import 'package:movie_app/features/home/presentation/screens/main_screen.dart';
import 'package:movie_app/features/view_more/actors/ui/bloc/actor_pagination_cubit.dart';
import 'package:movie_app/features/view_more/actors/ui/screen/view_more_actors_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.main:
        return MaterialPageRoute(builder: (_) => const MovieAppMainScreen());

      case AppRoutes.movieDetails:
        int movieId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => MovieDetailsCubit(),
              ),
              BlocProvider(create: (context) => RecommendedMoviesCubit()),
              BlocProvider(create: (context) => SimilarMoviesCubit()),
            ],
            child: DetailsScreen(movieId: movieId),
          ),
        );
       case AppRoutes.viewMoreActorsScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ActorPaginationCubit(),
              ),
          
            ],
            child: const ViewMoreActorsScreen(),
          ),
        ); 

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
