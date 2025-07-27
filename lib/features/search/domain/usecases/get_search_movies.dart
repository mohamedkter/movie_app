import 'package:dartz/dartz.dart';
import 'package:movie_app/core/errors/failure.dart';
import 'package:movie_app/features/home/domain/entities/Movie_entity.dart';
import 'package:movie_app/features/search/domain/repositories/search_repository.dart';

class GetSearchMovies{
 final SearchRepository repository ;
  GetSearchMovies({required this.repository});
  Future<Either<Failure,List<MovieEntity>>> call({required int page, required String query}) { {
     return  repository.getSearchMovies(query:query ,page:page);
  }
}}