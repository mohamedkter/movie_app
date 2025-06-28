import 'package:dartz/dartz.dart';
import 'package:movie_app/core/errors/failure.dart';
import 'package:movie_app/features/view_more/actors/domain/entities/actor_entity.dart';


abstract class ActorRepository {
  Future<Either<Failure, List<ActorEntity>>> getActors({required int page});
}
