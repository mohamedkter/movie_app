import 'dart:convert';
import 'package:movie_app/core/cache/cache_helper.dart';
import 'package:movie_app/features/home/data/models/MovieModel.dart';
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
