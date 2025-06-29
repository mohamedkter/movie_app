import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:movie_app/core/api/api_consumer.dart';
import 'package:movie_app/core/api/dio_consumer.dart';
import 'package:movie_app/core/cache/cache_helper.dart';
import 'package:movie_app/core/connection/network_info.dart';
import 'package:movie_app/features/details/data/datasources/details_remote_datasource.dart';
import 'package:movie_app/features/details/domain/repositories/details_repository.dart';
import 'package:movie_app/features/details/domain/usecases/get_recommended_movies.dart';
import 'package:movie_app/features/details/domain/usecases/get_similar_movies.dart';
import 'package:movie_app/features/details/ui/bloc/recommended_movies_cubit.dart';
import 'package:movie_app/features/details/ui/bloc/similar_movies_cubit.dart';
import 'package:movie_app/features/home/data/datasources/home_local_datasource.dart';
import 'package:movie_app/features/details/data/repo/details_repository_impl.dart';
import 'package:movie_app/features/details/domain/usecases/get_move_details.dart';
import 'package:movie_app/features/details/ui/bloc/movie_details_cubit.dart';
import 'package:movie_app/features/home/data/datasources/home_remote_datasource.dart';
import 'package:movie_app/features/home/data/repo/home_repository_impl.dart';
import 'package:movie_app/features/home/domain/repositories/home_repository.dart';
import 'package:movie_app/features/home/domain/usecases/get_trending_movies.dart';
import 'package:movie_app/features/home/domain/usecases/get_trending_persone.dart';
import 'package:movie_app/features/home/domain/usecases/get_upcoming_movies.dart';
import 'package:movie_app/features/home/presentation/bloc/trending_cubit.dart';
import 'package:movie_app/features/home/presentation/bloc/trending_people_cubit.dart';
import 'package:movie_app/features/home/presentation/bloc/upcoming_cubit.dart';
import 'package:movie_app/features/view_more/actors/data/datasources/actor_remote_dataSource.dart';
import 'package:movie_app/features/view_more/actors/data/repo/actor_repository_Impl.dart';
import 'package:movie_app/features/view_more/actors/domain/repo/actor_repository.dart';
import 'package:movie_app/features/view_more/actors/domain/usecases/get_actors_usecase.dart';
import 'package:movie_app/features/view_more/actors/ui/bloc/actor_pagination_cubit.dart';

final getIt = GetIt.instance;

void setupLocator() {
  //! Core
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<CacheHelper>(() => CacheHelper());
  getIt.registerLazySingleton<DataConnectionChecker>(
      () => DataConnectionChecker());
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));
  getIt.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: getIt()));

  //! DataSources

//Home
  getIt.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSource(cache: getIt()),
  );

//Details
  getIt.registerLazySingleton<DetailsRemoteDataSource>(
    () => DetailsRemoteDataSource(api: getIt()),
  );

  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSource(api: getIt()),
  );
//Show more
  getIt.registerLazySingleton<ActorRemoteDataSource>(
    () => ActorRemoteDataSourceImpl(api: getIt()),
  );
  //! Repository
  //Home
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );

  //Details
  getIt.registerLazySingleton<DetailsRepository>(
    () => DetailsRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );


  //Show more
  
  getIt.registerLazySingleton<ActorRepository>(
    () => ActorRepositoryImpl(
      remoteDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );

  //! UseCase

  //Home
  getIt.registerLazySingleton<GetTrendingMovies>(
    () => GetTrendingMovies(repository: getIt()),
  );
  getIt.registerLazySingleton<GetUpcomingMovies>(
    () => GetUpcomingMovies(repository: getIt()),
  );
  getIt.registerLazySingleton<GetTrendingPerson>(
    () => GetTrendingPerson(repository: getIt()),
  );

  //Details
  getIt.registerLazySingleton<GetMovieDetails>(
    () => GetMovieDetails(repository: getIt()),
  );
  getIt.registerLazySingleton<GetRecommendedMovies>(
    () => GetRecommendedMovies(repository: getIt()),
  );
  getIt.registerLazySingleton<GetSimilarMovies>(
    () => GetSimilarMovies(repository: getIt()),
  );

//Show More
  getIt.registerLazySingleton<GetActorsUseCase>(
    () => GetActorsUseCase(getIt()),
  );
  //! Cubit
  //Home
  getIt.registerFactory<TrendingCubit>(
    () => TrendingCubit(getIt()),
  );
  getIt.registerFactory<UpcomingCubit>(
    () => UpcomingCubit(getIt()),
  );
  getIt.registerFactory<TrendingPeopleCubit>(
    () => TrendingPeopleCubit(getIt()),
  );

  //Details
  getIt.registerFactory<MovieDetailsCubit>(() => MovieDetailsCubit(getIt()));
  getIt.registerFactory<RecommendedMoviesCubit>(
    () => RecommendedMoviesCubit(getIt()),
  );
  getIt.registerFactory<SimilarMoviesCubit>(
    () => SimilarMoviesCubit(getIt()),
  );

  //Show More
  getIt.registerFactory<ActorPaginationCubit>(
    () => ActorPaginationCubit(getIt()),
  );
}
