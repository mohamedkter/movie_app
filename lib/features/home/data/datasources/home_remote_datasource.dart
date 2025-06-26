import 'dart:developer';

import 'package:movie_app/core/api/api_consumer.dart';
import 'package:movie_app/features/home/data/models/MovieModel.dart';

// class HomeRemoteDatasource{
//   final DioConsumer apiConsumer ;
//   HomeRemoteDatasource({required this.apiConsumer});
//   Future<Either<List<MovieModel>, Failure>> fetchData( ) async {
//      try {
//        final response = await apiConsumer.get(
//          'trending/movie/day?language=en-US',
//        );
//        print(response);
//        return Left(response.data["results"].map<MovieModel>((e) => MovieModel.fromMap(e)).toList()); 
//      } catch (error) {
//       print(error);
//        return Right(Failure(errMessage: error.toString()));
//      }
//   }
// }
class HomeRemoteDataSource {
  final ApiConsumer api;

  HomeRemoteDataSource({required this.api});
  Future<List<MovieModel>> getTrendingMovies() async {
    Map<String,List<MovieModel>> HomeMovies = {};
    
    final response = await api.get("/trending/movie/day?language=en-US");

    return response["results"].map<MovieModel>((e) => MovieModel.fromMap(e)).toList();
  }
   Future<List<MovieModel>> getUpcomingMovies() async {
    final response = await api.get("/movie/upcoming?language=en-US&page=1");

    return response["results"].map<MovieModel>((e) => MovieModel.fromMap(e)).toList();
  }
}
