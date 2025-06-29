import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/home/domain/usecases/get_upcoming_movies.dart';
import 'package:movie_app/features/home/presentation/bloc/upcoming_states.dart';

class UpcomingCubit extends Cubit<UpcomingStates> {
  final GetUpcomingMovies getUpcomingMovies;

  UpcomingCubit(this.getUpcomingMovies) : super(InitialState());

  Future<void> eitherFailureOrUpcoming() async {
    emit(UpcomingLoadingState());

    final upcomingResult = await getUpcomingMovies.call();

    upcomingResult.fold(
      (failure) => emit(UpcomingErrorState(error: failure.errMessage)),
      (upcomingMovies) => emit(UpcomingSuccessState(upcomingMovies: upcomingMovies)),
    );
  }
}
