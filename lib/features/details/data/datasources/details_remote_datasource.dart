
import 'package:movie_app/core/api/api_consumer.dart';
import 'package:movie_app/core/utils/models/MovieModel.dart';
import 'package:movie_app/features/details/data/models/details_movie_model.dart';


class DetailsRemoteDataSource {
  final ApiConsumer api;
  DetailsRemoteDataSource({required this.api});
  Future<DetailsMovieModel> getMovieDetails(int movieId) async {
   final responses = await Future.wait([
    api.get("/movie/$movieId?language=en-US"),
    api.get("/movie/$movieId/credits?language=en-US"),
  ]);
    return DetailsMovieModel.fromJson(responses[0], responses[1]);
  }
  Future<List<MovieModel>> getSimilarMovies(int movieId) async {
    final response = await api.get("/movie/$movieId/similar");
    final List<dynamic> results = response['results'];
    return results.map((e) => MovieModel.fromMap(e)).toList();
  }

  Future<List<MovieModel>> getRecommendedMovies(int movieId) async {
    final response = await api.get("/movie/$movieId/recommendations");
    final List<dynamic> results = response['results'];
    return results.map((e) => MovieModel.fromMap(e)).toList();
  }
}
