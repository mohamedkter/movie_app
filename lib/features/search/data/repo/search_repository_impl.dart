import 'package:dartz/dartz.dart';
import 'package:movie_app/core/connection/network_info.dart';
import 'package:movie_app/core/errors/expentions.dart';
import 'package:movie_app/core/errors/failure.dart';
import 'package:movie_app/core/utils/models/MovieModel.dart';
import 'package:movie_app/features/search/data/datasources/search_remote_datasource.dart';
import 'package:movie_app/features/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl extends SearchRepository {
  final NetworkInfo networkInfo;
  final SearchRemoteDataSource remoteDataSource;
  SearchRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, List<MovieModel>>> getSearchMovies(
      {required int page, required String query}) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteTrendingMovies =
            await remoteDataSource.getSearchMovies(query: query, page: page);
        return Right(remoteTrendingMovies);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "No Internet Connection"));
    }
  }
}
