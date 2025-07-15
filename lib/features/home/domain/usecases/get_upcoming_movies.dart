import 'package:dartz/dartz.dart';
import 'package:movie_app/core/errors/failure.dart';
import 'package:movie_app/features/home/domain/entities/Movie_entity.dart';
import 'package:movie_app/features/home/domain/repositories/home_repository.dart';

class GetUpcomingMovies {
  final HomeRepository repository;

  GetUpcomingMovies({required this.repository});

  Future<Either<Failure, List<MovieEntity>>> call({required int page}) {
    return repository.getUpcomingMovies(page: page);
  }
}
