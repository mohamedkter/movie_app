import 'package:dartz/dartz.dart';
import 'package:movie_app/core/errors/failure.dart';
import 'package:movie_app/features/home/domain/entities/Movie_entity.dart';
import 'package:movie_app/features/home/domain/repositories/home_repository.dart';

class GetTrendingMovies{
 final HomeRepository repository ;
  GetTrendingMovies({required this.repository});
  Future<Either<Failure,List<MovieEntity>>> call({required int page})  {
     return  repository.getTrendingMovies(page:page);
  }
}