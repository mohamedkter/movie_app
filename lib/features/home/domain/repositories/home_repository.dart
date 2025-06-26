import 'package:dartz/dartz.dart';
import 'package:movie_app/features/home/domain/entities/Movie_entity.dart';
import 'package:movie_app/features/home/domain/entities/people_entity.dart';
import '../../../../core/errors/failure.dart';


abstract class HomeRepository {
  Future<Either<Failure, List<MovieEntity>>> getTrendingMovies();
  Future<Either<Failure, List<MovieEntity>>> getUpcomingMovies();
  Future<Either<Failure, List<PeopleEntity>>> getTrendingPerson();                 
}
