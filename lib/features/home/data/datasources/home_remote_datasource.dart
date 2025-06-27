import 'dart:developer';

import 'package:movie_app/core/api/api_consumer.dart';
import 'package:movie_app/core/utils/models/MovieModel.dart';
import 'package:movie_app/features/home/data/models/people_model.dart';

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
  Future<List<PeopleModel>> getTrendingPerson() async {
    final response = await api.get("/trending/person/day?language=en-US");
    return response["results"].map<PeopleModel>((e) => PeopleModel.fromJson(e)).toList();
  }
}
