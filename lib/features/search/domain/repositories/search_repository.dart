import 'package:dartz/dartz.dart';
import 'package:movie_app/features/home/domain/entities/Movie_entity.dart';
import '../../../../core/errors/failure.dart';


abstract class SearchRepository {
  Future<Either<Failure, List<MovieEntity>>> getSearchMovies({required String query , required int page});             
}
