import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/details/domain/entities/details_movie_entity.dart';
import 'package:movie_app/features/details/ui/bloc/movie_details_cubit.dart';
import 'package:movie_app/features/details/ui/bloc/movie_details_states.dart';
import 'package:movie_app/features/details/ui/bloc/recommended_movies_cubit.dart';
import 'package:movie_app/features/details/ui/bloc/similar_movies_cubit.dart';
import 'package:movie_app/features/details/ui/widgets/movie_cast_section.dart';
import 'package:movie_app/features/details/ui/widgets/movie_trailer_widget.dart';
import 'package:movie_app/features/details/ui/widgets/recommended_movies_section.dart';
import 'package:movie_app/features/details/ui/widgets/similar_movies_section.dart';
import 'package:movie_app/features/details/ui/widgets/story_line_widget.dart';

class DetailsScreen extends StatefulWidget {
  final int movieId;
  const DetailsScreen({super.key, required this.movieId});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  DetailsMovieEntity? movieDetails;
  @override
  void initState() {
    super.initState();
    context.read<MovieDetailsCubit>().fetchMovieDetails(widget.movieId);
    context
        .read<RecommendedMoviesCubit>()
        .fetchRecommendedMovies(widget.movieId);
    context.read<SimilarMoviesCubit>().fetchSimilarMovies(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<MovieDetailsCubit, MovieDetailsStates>(
            builder: (context, state) {
          if (state is MovieDetailsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieDetailsSuccessState) {
            movieDetails = state.movieDetails;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MovieTrailerWidget(
                    isFavorite: true,
                    iconButtonFunction: () {
                      setState(() {
                        //is_Favorite = !is_Favorite;
                      });
                    },
                    movieDetails: movieDetails,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  StorylineWidget(
                    storylineText: movieDetails == null
                        ? "overview"
                        : movieDetails?.overview ?? 'No overview available',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  movieDetails!.productionCompany != null &&
                          movieDetails!.productionCompany!.isNotEmpty
                      ? ProductionCompanySection(movieDetails: movieDetails)
                      : const SizedBox(
                          width: 0,
                        ),
                  const SizedBox(
                    height: 15,
                  ),
                  MovieCastSection(movieDetails: movieDetails),
                  const SizedBox(
                    height: 15,
                  ),
                  const SimilarMoviesSection(),
                  const SizedBox(
                    height: 15,
                  ),
                  const RecommendedMoviesSection(),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            );
          } else if (state is MovieDetailsErrorState) {
            return Center(
              child: Text(state.errorMessage),
            );
          }
          return const SizedBox.shrink();
        }));
  }
}
