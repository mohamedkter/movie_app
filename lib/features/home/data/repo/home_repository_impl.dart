import 'package:dartz/dartz.dart';
import 'package:movie_app/core/connection/network_info.dart';
import 'package:movie_app/core/errors/expentions.dart';
import 'package:movie_app/core/errors/failure.dart';
import 'package:movie_app/features/home/data/datasources/home_local_datasource.dart';
import 'package:movie_app/features/home/data/datasources/home_remote_datasource.dart';
import 'package:movie_app/core/utils/models/MovieModel.dart';
import 'package:movie_app/features/home/domain/entities/Movie_entity.dart';
import 'package:movie_app/features/home/domain/entities/people_entity.dart';
import 'package:movie_app/features/home/domain/repositories/home_repository.dart';



class HomeRepositoryImpl extends HomeRepository {
  final NetworkInfo networkInfo;
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;
  HomeRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, List<MovieModel>>> getTrendingMovies() async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteTrendingMovies = await remoteDataSource.getTrendingMovies();
        localDataSource.cacheMovie(remoteTrendingMovies, key: "trendingMovies");
        return Right(remoteTrendingMovies);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      try {
        print("No Internet Connection");
        final localTemplate = await localDataSource.getLastMovieList(key: "trendingMovies");
        return Right(localTemplate);
      } on CacheExeption catch (e) {
        return Left(Failure(errMessage: e.errorMessage));
      }
    }
  }
  @override
  Future<Either<Failure, List<MovieEntity>>> getUpcomingMovies() async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteUpcomingMovies = await remoteDataSource.getUpcomingMovies();
        localDataSource.cacheMovie(remoteUpcomingMovies, key: "upcomingMovies");
        return Right(remoteUpcomingMovies);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      try {
        print("No Internet Connection");
        final localTemplate = await localDataSource.getLastMovieList(key: "upcomingMovies");
        return Right(localTemplate);
      } on CacheExeption catch (e) {
        return Left(Failure(errMessage: e.errorMessage));
      }
    }
  }

  @override
  Future<Either<Failure, List<PeopleEntity>>> getTrendingPerson() async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteTrendingPerson = await remoteDataSource.getTrendingPerson();
        localDataSource.cachePeople(remoteTrendingPerson, key: "trendingPeople");
        return Right(remoteTrendingPerson);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      try {
        print("No Internet Connection");
        final localTemplate = await localDataSource.getLastPeopleList(key: "trendingPeople");
        return Right(localTemplate);
      } on CacheExeption catch (e) {
        return Left(Failure(errMessage: e.errorMessage));
      }
    }
  }
}
