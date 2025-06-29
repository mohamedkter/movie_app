import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/details/domain/usecases/get_move_details.dart';
import 'package:movie_app/features/details/ui/bloc/movie_details_states.dart';


class MovieDetailsCubit extends Cubit<MovieDetailsStates> {
  final GetMovieDetails getMovieDetails;

  MovieDetailsCubit(this.getMovieDetails) : super(MovieDetailsInitialState());

  Future<void> fetchMovieDetails(int movieId) async {
    emit(MovieDetailsLoadingState());
    final result = await getMovieDetails.call(movieId);
    result.fold(
      (failure) =>
          emit(MovieDetailsErrorState(errorMessage: failure.errMessage)),
      (movieDetails) {
        emit(MovieDetailsSuccessState(movieDetails: movieDetails));
      },
    );
  }
}