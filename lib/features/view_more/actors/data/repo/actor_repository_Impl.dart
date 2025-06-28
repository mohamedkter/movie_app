import 'package:dartz/dartz.dart';
import 'package:movie_app/core/errors/expentions.dart';
import 'package:movie_app/core/errors/failure.dart';
import 'package:movie_app/core/connection/network_info.dart';
import 'package:movie_app/features/view_more/actors/data/datasources/actor_remote_dataSource.dart';
import 'package:movie_app/features/view_more/actors/domain/entities/actor_entity.dart';
import 'package:movie_app/features/view_more/actors/domain/repo/actor_repository.dart';


class ActorRepositoryImpl extends ActorRepository {
  final ActorRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ActorRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ActorEntity>>> getActors({required int page}) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteActors = await remoteDataSource.getActors(page: page);
        return Right(remoteActors);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "No Internet Connection"));
    }
  }
}
