import 'package:movie_app/features/home/domain/entities/Movie_entity.dart';

abstract class ViewMoreMoviesState {}

class ViewMoreMoviesInitial extends ViewMoreMoviesState {}

class ViewMoreMoviesLoading extends ViewMoreMoviesState {}

class ViewMoreMoviesSuccess extends ViewMoreMoviesState {
  final List<MovieEntity> movies;
  final bool hasMore;

  ViewMoreMoviesSuccess({required this.movies, required this.hasMore});
}

class ViewMoreMoviesError extends ViewMoreMoviesState {
  final String error;

  ViewMoreMoviesError(this.error);
}
