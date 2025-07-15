import 'package:dartz/dartz.dart';
import 'package:movie_app/core/errors/failure.dart';
import 'package:movie_app/features/details/domain/repositories/details_repository.dart';
import 'package:movie_app/features/home/domain/entities/Movie_entity.dart';

class GetRecommendedMovies {
  final DetailsRepository repository;

  GetRecommendedMovies({required this.repository});

  Future<Either<Failure, List<MovieEntity>>> call(int movieId,page) {
    return repository.getRecommendedMovies(movieId,page);
  }
}
