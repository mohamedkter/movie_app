import 'package:dartz/dartz.dart';
import 'package:movie_app/core/errors/failure.dart';
import 'package:movie_app/features/details/domain/entities/details_movie_entity.dart';
import 'package:movie_app/features/details/domain/repositories/details_repository.dart';

class GetMovieDetails {
  final DetailsRepository repository;

  GetMovieDetails({required this.repository});

  Future<Either<Failure, DetailsMovieEntity>> call(int movieId) {
    return repository.getMovieDetails(movieId);
  }
}
