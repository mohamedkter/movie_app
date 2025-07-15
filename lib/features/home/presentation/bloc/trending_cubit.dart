import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/home/domain/usecases/get_trending_movies.dart';
import 'package:movie_app/features/home/presentation/bloc/trending_states.dart';

class TrendingCubit extends Cubit<TrendingState> {
  final GetTrendingMovies getTrendingMovies;

  TrendingCubit(this.getTrendingMovies) : super(InitialState());

  Future<void> eitherFailureOrTrending() async {
    emit(TrendingLoadingState());

    final trendingResult = await getTrendingMovies.call(page: 1);

    trendingResult.fold(
      (failure) => emit(TrendingErrorState(error: failure.errMessage)),
      (trendingMovies) => emit(TrendingSuccessState(trendingMovies: trendingMovies)),
    );
  }
}
