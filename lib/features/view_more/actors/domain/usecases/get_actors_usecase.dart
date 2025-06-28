import 'package:dartz/dartz.dart';
import 'package:movie_app/core/errors/failure.dart';
import 'package:movie_app/features/view_more/actors/domain/entities/actor_entity.dart';
import 'package:movie_app/features/view_more/actors/domain/repo/actor_repository.dart';

class GetActorsUseCase {
  final ActorRepository repository;

  GetActorsUseCase(this.repository);

  Future<Either<Failure, List<ActorEntity>>> call({required int page}) {
    return repository.getActors(page: page);
  }
}
