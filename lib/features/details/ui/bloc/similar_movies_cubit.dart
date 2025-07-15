import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/details/domain/usecases/get_similar_movies.dart';
import 'package:movie_app/features/details/ui/bloc/similar_movies_state.dart';

class SimilarMoviesCubit extends Cubit<SimilarMoviesState> {
  final GetSimilarMovies getSimilarMovies;

  SimilarMoviesCubit(this.getSimilarMovies)
      : super(SimilarMoviesInitialState());

  Future<void> fetchSimilarMovies(int movieId) async {
    emit(SimilarMoviesLoadingState());
    final result = await getSimilarMovies.call(movieId,1);
    result.fold(
      (failure) =>
          emit(SimilarMovieErrorState(errorMessage: failure.errMessage)),
      (movies) {
        emit(SimilarMoviesSuccessState(movies: movies));
      },
    );
  }
}
