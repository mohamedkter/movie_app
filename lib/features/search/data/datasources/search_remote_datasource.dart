import 'package:movie_app/core/api/api_consumer.dart';
import 'package:movie_app/core/utils/models/MovieModel.dart';

class SearchRemoteDataSource {
  final ApiConsumer api;

  SearchRemoteDataSource({required this.api});
  Future<List<MovieModel>> getSearchMovies(
      {required int page, required String query}) async {
        print("Search query: $query, page: $page");
    final response = await api
        .get("/search/movie?query=$query&include_adult=false&page=$page");
        print("Search response: $response");
    return response["results"]
        .map<MovieModel>((e) => MovieModel.fromMap(e))
        .toList();
  }
}
