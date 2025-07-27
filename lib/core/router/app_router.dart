import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/enums/movie_section.dart';
import 'package:movie_app/core/router/app_routes.dart';
import 'package:movie_app/core/services/service_locator.dart';
import 'package:movie_app/features/auth/email_verification/ui/screen/email_verification_screen.dart';
import 'package:movie_app/features/auth/signin/ui/screen/signin_screen.dart';
import 'package:movie_app/features/auth/signin/ui/signin_cubit/signin_cubit.dart';
import 'package:movie_app/features/auth/signup/ui/screen/signup_screen.dart';
import 'package:movie_app/features/auth/signup/ui/signup_cubit/signup_cubit.dart';
import 'package:movie_app/features/details/ui/bloc/movie_details_cubit.dart';
import 'package:movie_app/features/details/ui/bloc/recommended_movies_cubit.dart';
import 'package:movie_app/features/details/ui/bloc/similar_movies_cubit.dart';
import 'package:movie_app/features/details/ui/screen/details_screen.dart';
import 'package:movie_app/features/home/presentation/screens/main_screen.dart';
import 'package:movie_app/features/view_more/actors/ui/bloc/actor_pagination_cubit.dart';
import 'package:movie_app/features/view_more/actors/ui/screen/view_more_actors_screen.dart';
import 'package:movie_app/features/view_more/movies/ui/bloc/view_more_movies_cubit.dart';
import 'package:movie_app/features/view_more/movies/ui/screen/view_more_movies_screen.dart';

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
                create: (_) => getIt<MovieDetailsCubit>(),
              ),
              BlocProvider(
                  create: (context) => getIt<RecommendedMoviesCubit>()),
              BlocProvider(create: (context) => getIt<SimilarMoviesCubit>()),
            ],
            child: DetailsScreen(movieId: movieId),
          ),
        );

      case AppRoutes.viewMoreActorsScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<ActorPaginationCubit>(),
              ),
            ],
            child: const ViewMoreActorsScreen(),
          ),
        );
      case AppRoutes.viewMoreMoviesScreen:
        MovieSection section = settings.arguments as MovieSection;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIt<ViewMoreMoviesCubit>(),
                  child: ViewMoreMoviesScreen(
                    section: section,
                  ),
                ));
      case AppRoutes.signIn:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => SigninCubit(),
                  child: const SigninScreen(),
                ));
      case AppRoutes.signup:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => SignupCubit(),
                  child: const SignupScreen(),
                ));
      case AppRoutes.emailVerification:
        return MaterialPageRoute(
            builder: (context) => const EmailVerificationScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
