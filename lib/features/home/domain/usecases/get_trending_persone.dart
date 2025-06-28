import 'package:dartz/dartz.dart';
import 'package:movie_app/core/errors/failure.dart';
import 'package:movie_app/features/home/domain/entities/people_entity.dart';
import 'package:movie_app/features/home/domain/repositories/home_repository.dart';

class GetTrendingPerson{
 final HomeRepository repository ;
  GetTrendingPerson({required this.repository});
  Future<Either<Failure,List<PeopleEntity>>> call()  {
     return  repository.getTrendingPerson();
  }
}