import 'package:movie_app/features/home/domain/entities/Movie_entity.dart';

abstract class SearchMoviesState {}

class SearchMoviesInitial extends SearchMoviesState {}

class SearchMoviesLoading extends SearchMoviesState {}

class SearchMoviesLoaded extends SearchMoviesState {
  final List<MovieEntity> movies;
  final bool hasMore;
  final bool isLoadingMore;

  SearchMoviesLoaded({
    required this.movies,
    required this.hasMore,
    this.isLoadingMore = false,
  });

  SearchMoviesLoaded copyWith({
    List<MovieEntity>? movies,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return SearchMoviesLoaded(
      movies: movies ?? this.movies,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class SearchMoviesError extends SearchMoviesState {
  final String message;
  SearchMoviesError(this.message);
}
