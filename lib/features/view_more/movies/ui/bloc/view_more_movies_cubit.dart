import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/enums/movie_section.dart';
import 'package:movie_app/features/home/domain/usecases/get_trending_movies.dart';
import 'package:movie_app/features/home/domain/usecases/get_upcoming_movies.dart';
import '../bloc/view_more_movies_state.dart';

class ViewMoreMoviesCubit extends Cubit<ViewMoreMoviesState> {
  final GetTrendingMovies getTrendingMovies;
  final GetUpcomingMovies getUpcomingMovies;
  // Add more use cases if needed later

  int currentPage = 1;
  bool hasMore = true;
  MovieSection? currentSection;

  ViewMoreMoviesCubit({
    required this.getTrendingMovies,
    required this.getUpcomingMovies,
  }) : super(ViewMoreMoviesInitial());

  Future<void> fetchMovies(MovieSection section) async {
    emit(ViewMoreMoviesLoading());
    currentSection = section;
    currentPage = 1;

    final result = await _getUseCaseBySection(section).call(page:currentPage);

    result.fold(
      (failure) => emit(ViewMoreMoviesError(failure.errMessage)),
      (movies) {
        hasMore = movies.length >= 20;
        emit(ViewMoreMoviesSuccess(movies: movies, hasMore: hasMore));
      },
    );
  }

  Future<void> fetchMoreMovies() async {
    if (!hasMore || currentSection == null) return;
    currentPage++;

    final result = await _getUseCaseBySection(currentSection!).call(page :currentPage);

    result.fold((failure) {}, (newMovies) {
      hasMore = newMovies.length >= 20;
      final currentState = state as ViewMoreMoviesSuccess;
      emit(ViewMoreMoviesSuccess(
        movies: currentState.movies + newMovies,
        hasMore: hasMore,
      ));
    });
  }

  dynamic _getUseCaseBySection(MovieSection section) {
    switch (section) {
      case MovieSection.trending:
        return getTrendingMovies;
      case MovieSection.upcoming:
        return getUpcomingMovies;
      // Add other sections here
      default:
        throw Exception("Section not supported");
    }
  }
}
