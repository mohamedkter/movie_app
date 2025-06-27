import 'package:dartz/dartz.dart';
import 'package:movie_app/features/details/domain/entities/details_movie_entity.dart';
import 'package:movie_app/features/home/domain/entities/Movie_entity.dart';
import '../../../../core/errors/failure.dart';


abstract class DetailsRepository {
  Future<Either<Failure, DetailsMovieEntity>> getMovieDetails(movieId); 
  Future<Either<Failure, List<MovieEntity>>> getSimilarMovies(movieId);
  Future<Either<Failure, List<MovieEntity>>> getRecommendedMovies(movieId);        
}
