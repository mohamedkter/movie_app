import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/search/domain/usecases/get_search_movies.dart';
import 'package:movie_app/features/search/ui/bloc/search_movies_state.dart';

class SearchMoviesCubit extends Cubit<SearchMoviesState> {
  final GetSearchMovies getSearchMovies;

  int currentPage = 1;
  bool hasMore = true;
  String currentQuery = '';

  SearchMoviesCubit(this.getSearchMovies) : super(SearchMoviesInitial());

  Future<void> fetchInitialSearch(String query) async {
    emit(SearchMoviesLoading());
    currentPage = 1;
    currentQuery = query;

    final result = await getSearchMovies.call(page: currentPage, query: query);
    result.fold(
      (failure) => emit(SearchMoviesError(failure.errMessage)),
      (movies) {
        hasMore = movies.length >= 20;
        emit(SearchMoviesLoaded(
          movies: movies,
          hasMore: hasMore,
        ));
      },
    );
  }

  Future<void> fetchMoreSearch() async {
    if (state is! SearchMoviesLoaded || !hasMore) return;

    final currentState = state as SearchMoviesLoaded;
    emit(currentState.copyWith(isLoadingMore: true));

    currentPage++;
    final result = await getSearchMovies.call(page: currentPage, query: currentQuery);
    result.fold(
      (_) => emit(currentState.copyWith(isLoadingMore: false)),
      (newMovies) {
        hasMore = newMovies.length >= 20;
        emit(SearchMoviesLoaded(
          movies: currentState.movies + newMovies,
          hasMore: hasMore,
        ));
      },
    );
  }
}
