import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/api/dio_consumer.dart';
import 'package:movie_app/core/cache/cache_helper.dart';
import 'package:movie_app/core/connection/network_info.dart';
import 'package:movie_app/features/details/data/datasources/details_remote_datasource.dart';
import 'package:movie_app/features/details/data/repo/details_repository_impl.dart';
import 'package:movie_app/features/details/domain/repositories/details_repository.dart';
import 'package:movie_app/features/details/domain/usecases/get_move_details.dart';
import 'package:movie_app/features/details/ui/bloc/movie_details_states.dart';
import 'package:movie_app/features/home/data/datasources/home_local_datasource.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsStates> {
  MovieDetailsCubit() : super(MovieDetailsInitialState());
  final detailsRepository = DetailsRepositoryImpl(
    remoteDataSource: DetailsRemoteDataSource(api: DioConsumer(dio: Dio())),
    localDataSource: HomeLocalDataSource(cache: CacheHelper()),
    networkInfo: NetworkInfoImpl(DataConnectionChecker()),
  );

  Future<void> fetchMovieDetails(int movieId) async {
    emit(MovieDetailsLoadingState());
    final result = await GetMovieDetails(
      repository: detailsRepository,
    ).call(movieId);
    result.fold(
      (failure) =>
          emit(MovieDetailsErrorState(errorMessage: failure.errMessage)),
      (movieDetails) {
        emit(MovieDetailsSuccessState(movieDetails: movieDetails));
      },
    );
  }
}
