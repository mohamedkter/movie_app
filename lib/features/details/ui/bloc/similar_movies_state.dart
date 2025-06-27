import 'package:movie_app/features/home/domain/entities/Movie_entity.dart';

abstract class SimilarMoviesState {}
class SimilarMoviesInitialState extends SimilarMoviesState {}
class SimilarMoviesLoadingState extends SimilarMoviesState {}
class SimilarMoviesSuccessState extends SimilarMoviesState {
  final List<MovieEntity> movies;
  SimilarMoviesSuccessState({required this.movies});
}
class SimilarMovieErrorState extends SimilarMoviesState {
  final String errorMessage;
  SimilarMovieErrorState({required this.errorMessage});
}