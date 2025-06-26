import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/api/dio_consumer.dart';
import 'package:movie_app/core/cache/cache_helper.dart';
import 'package:movie_app/core/connection/network_info.dart';
import 'package:movie_app/features/home/data/datasources/home_local_datasource.dart';
import 'package:movie_app/features/home/data/datasources/home_remote_datasource.dart';
import 'package:movie_app/features/home/data/repo/home_repository_impl.dart';
import 'package:movie_app/features/home/domain/entities/Movie_entity.dart';
import 'package:movie_app/features/home/domain/usecases/get_upcoming_movies.dart';
import 'package:movie_app/features/home/presentation/bloc/upcoming_states.dart';



class UpcomingCubit extends Cubit<UpcomingStates> {
  UpcomingCubit() : super(InitialState());

  eitherFailureOrUpcoming() async {
  emit(UpcomingLoadingState());

  final repository = HomeRepositoryImpl(
    remoteDataSource: HomeRemoteDataSource(api: DioConsumer(dio: Dio())),
    localDataSource: HomeLocalDataSource(cache: CacheHelper()),
    networkInfo: NetworkInfoImpl(DataConnectionChecker()),
  );

  final upcomingResult = await GetUpcomingMovies(repository: repository).call();
  if (upcomingResult.isLeft()) {
    upcomingResult.fold(
      (failure) => emit(UpcomingErrorState(error: failure.errMessage)),
      (_) {},
    );
    return;
  }
  final upcomingMovies = upcomingResult.fold<List<MovieEntity>>((l) => <MovieEntity>[], (r) => r);

  emit(UpcomingSuccessState(
    upcomingMovies: upcomingMovies,
  ));
}
}
