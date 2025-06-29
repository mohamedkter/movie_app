import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/details/domain/usecases/get_recommended_movies.dart';
import 'package:movie_app/features/details/ui/bloc/recommended_movies_state.dart';

class RecommendedMoviesCubit extends Cubit<RecommendedMoviesState> {
  final GetRecommendedMovies getRecommendedMovies;

  RecommendedMoviesCubit(this.getRecommendedMovies)
      : super(RecommendedMoviesInitialState());

  Future<void> fetchRecommendedMovies(int movieId) async {
    emit(RecommendedMoviesLoadingState());
    final result = await getRecommendedMovies.call(movieId);
    result.fold(
      (failure) =>
          emit(RecommendedMovieErrorState(errorMessage: failure.errMessage)),
      (movies) {
        emit(RecommendedMoviesSuccessState(movies: movies));
      },
    );
  }
}
