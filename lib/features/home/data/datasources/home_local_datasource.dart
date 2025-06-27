import 'dart:convert';
import 'package:movie_app/core/cache/cache_helper.dart';
import 'package:movie_app/core/utils/models/MovieModel.dart';
import 'package:movie_app/features/home/data/models/people_model.dart';
import '../../../../core/errors/expentions.dart';

class HomeLocalDataSource {
  final CacheHelper cache;
  
  HomeLocalDataSource({required this.cache});

  void cacheMovie(List<MovieModel>? movieToCache, {required String key}) {
    if (movieToCache != null) {
      final jsonList = movieToCache.map((movie) => movie.toJson()).toList();

      cache.saveData(
        key: key,
        value: json.encode(jsonList),
      );
    } else {
      throw CacheExeption(errorMessage: "No Internet Connection");
    }
  }

 void cachePeople(List<PeopleModel>? peopleToCache, {required String key}) {
    if (peopleToCache != null) {
      final jsonList = peopleToCache.map((person) => person.toJson()).toList();

      cache.saveData(
        key: key,
        value: json.encode(jsonList),
      );
    } else {
      throw CacheExeption(errorMessage: "No Internet Connection");
    }
  }

  Future<List<PeopleModel>> getLastPeopleList({required String key}) async {
    final jsonString = cache.getDataString(key: key);

    if (jsonString != null) {
      final List<dynamic> decodedList = json.decode(jsonString);
      final List<PeopleModel> peopleList = decodedList
          .map((jsonItem) => PeopleModel.fromJson(jsonItem))
          .toList();
      return Future.value(peopleList);
    } else {
      throw CacheExeption(errorMessage: "No Internet Connection");
    }
  }
  Future<List<MovieModel>> getLastMovieList( {required String key}) async {
    final jsonString = cache.getDataString(key: key);

    if (jsonString != null) {
      final List<dynamic> decodedList = json.decode(jsonString);
      final List<MovieModel> movieList = decodedList
          .map((jsonItem) => MovieModel.fromMap(jsonItem))
          .toList();
      return Future.value(movieList);
    } else {
      throw CacheExeption(errorMessage: "No Internet Connection");
    }
  }

  
}
