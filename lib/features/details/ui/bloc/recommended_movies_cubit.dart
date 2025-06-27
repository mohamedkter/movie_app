import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/api/dio_consumer.dart';
import 'package:movie_app/core/cache/cache_helper.dart';
import 'package:movie_app/core/connection/network_info.dart';
import 'package:movie_app/features/details/data/datasources/details_remote_datasource.dart';
import 'package:movie_app/features/details/data/repo/details_repository_impl.dart';
import 'package:movie_app/features/details/domain/usecases/get_recommended_movies.dart';
import 'package:movie_app/features/details/ui/bloc/recommended_movies_state.dart';
import 'package:movie_app/features/home/data/datasources/home_local_datasource.dart';

class RecommendedMoviesCubit extends Cubit<RecommendedMoviesState> {
  final detailsRepository = DetailsRepositoryImpl(
    remoteDataSource: DetailsRemoteDataSource(api: DioConsumer(dio: Dio())),
    localDataSource: HomeLocalDataSource(cache: CacheHelper()),
    networkInfo: NetworkInfoImpl(DataConnectionChecker()),
  );
  RecommendedMoviesCubit()
      : super(RecommendedMoviesInitialState());

  Future<void> fetchRecommendedMovies(int movieId) async {
    emit(RecommendedMoviesLoadingState());
    final result = await GetRecommendedMovies(
      repository: detailsRepository,
    ).call(movieId);
    result.fold(
      (failure) =>
          emit(RecommendedMovieErrorState(errorMessage: failure.errMessage)),
      (movies) {
        emit(RecommendedMoviesSuccessState(movies: movies));
      },
    );
  }
}