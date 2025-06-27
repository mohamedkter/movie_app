import 'package:movie_app/features/home/domain/entities/Movie_entity.dart';

abstract class RecommendedMoviesState{}
class RecommendedMoviesInitialState extends RecommendedMoviesState{}
class RecommendedMoviesLoadingState extends RecommendedMoviesState{}
class RecommendedMoviesSuccessState extends RecommendedMoviesState{
  final List<MovieEntity> movies;
  RecommendedMoviesSuccessState({required this.movies});
}
class RecommendedMovieErrorState extends RecommendedMoviesState {
  final String errorMessage;
  RecommendedMovieErrorState({required this.errorMessage});
}