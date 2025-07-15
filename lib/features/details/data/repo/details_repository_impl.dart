import 'package:dartz/dartz.dart';
import 'package:movie_app/core/connection/network_info.dart';
import 'package:movie_app/core/errors/expentions.dart';
import 'package:movie_app/core/errors/failure.dart';
import 'package:movie_app/features/details/data/datasources/details_remote_datasource.dart';
import 'package:movie_app/features/details/domain/entities/details_movie_entity.dart';
import 'package:movie_app/features/details/domain/repositories/details_repository.dart';
import 'package:movie_app/features/home/data/datasources/home_local_datasource.dart';
import 'package:movie_app/features/home/domain/entities/Movie_entity.dart';

class DetailsRepositoryImpl extends DetailsRepository {
  final NetworkInfo networkInfo;
  final DetailsRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;
  DetailsRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, DetailsMovieEntity>> getMovieDetails(
      movieId) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteTrendingMovies =
            await remoteDataSource.getMovieDetails(movieId);
        // Wrap the single DetailsMovieEntity in a list
        return Right(remoteTrendingMovies);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      try {
        print("No Internet Connection");
        // final localTemplate = await localDataSource.getLastMovieList(key: "trendingMovies");
        // Ensure localTemplate is a List<DetailsMovieEntity>
        //return Right(localTemplate);
        return Left(Failure(
            errMessage:
                "No internet connection, unable to fetch movie details."));
      } on CacheExeption catch (e) {
        return Left(Failure(errMessage: e.errorMessage));
      }
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getSimilarMovies(
      movieId,page) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteSimilarMovies =
            await remoteDataSource.getSimilarMovies(movieId,page);
        return Right(remoteSimilarMovies);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      try {
        print("No Internet Connection");
        return Left(Failure(
            errMessage:
                "No internet connection, unable to fetch similar movies."));
      } on CacheExeption catch (e) {
        return Left(Failure(errMessage: e.errorMessage));
      }
    }

  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getRecommendedMovies(
      movieId,page) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteRecommendedMovies =
            await remoteDataSource.getRecommendedMovies(movieId,page);
        return Right(remoteRecommendedMovies);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      try {
        print("No Internet Connection");
        return Left(Failure(
            errMessage:
                "No internet connection, unable to fetch recommended movies."));
      } on CacheExeption catch (e) {
        return Left(Failure(errMessage: e.errorMessage));
      }
    }
  }


}
