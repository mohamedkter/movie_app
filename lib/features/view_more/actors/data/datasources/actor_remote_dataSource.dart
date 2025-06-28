import 'package:movie_app/core/api/api_consumer.dart';
import 'package:movie_app/features/view_more/actors/data/models/actor_model.dart';

abstract class ActorRemoteDataSource {
  Future<List<ActorModel>> getActors({required int page});
}

class ActorRemoteDataSourceImpl extends ActorRemoteDataSource {
  final ApiConsumer api;

  ActorRemoteDataSourceImpl({required this.api});

  @override
  Future<List<ActorModel>> getActors({required int page}) async {
    final response = await api.get("/person/popular?language=en-US&page=$page");
    return (response['results'] as List)
        .map((e) => ActorModel.fromJson(e))
        .toList();
  }
}
