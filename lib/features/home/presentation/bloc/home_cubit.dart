import 'dart:math';

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
import 'package:movie_app/features/home/domain/usecases/get_trending_movies.dart';
import 'package:movie_app/features/home/domain/usecases/get_upcoming_movies.dart';
import 'package:movie_app/features/home/presentation/bloc/home_states.dart';


class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  eitherFailureOrHomeData() async {
  emit(HomeLoadingState());

  final repository = HomeRepositoryImpl(
    remoteDataSource: HomeRemoteDataSource(api: DioConsumer(dio: Dio())),
    localDataSource: HomeLocalDataSource(cache: CacheHelper()),
    networkInfo: NetworkInfoImpl(DataConnectionChecker()),
  );

  final trendingResult = await GetTrendingMovies(repository: repository).call();
  final upcomingResult = await GetUpcomingMovies(repository: repository).call();

  if (trendingResult.isLeft()) {
    trendingResult.fold(
      (failure) => emit(HomeErrorState(error: failure.errMessage)),
      (_) {},
    );
    return;
  }

  if (upcomingResult.isLeft()) {
    upcomingResult.fold(
      (failure) => emit(HomeErrorState(error: failure.errMessage)),
      (_) {},
    );
    return;
  }

  final trendingMovies = trendingResult.fold<List<MovieEntity>>((l) => <MovieEntity>[], (r) => r);
  final upcomingMovies = upcomingResult.fold<List<MovieEntity>>((l) => <MovieEntity>[], (r) => r);

  emit(HomeSuccessState(
    trendingMovies: trendingMovies,
    upcomingMovies: upcomingMovies,
  ));
}
}
