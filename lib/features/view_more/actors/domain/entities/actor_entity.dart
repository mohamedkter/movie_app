import 'package:movie_app/features/view_more/actors/data/models/known_for_model.dart';

class ActorEntity {
  final int id;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final List<KnownForModel> knownFor;

  const ActorEntity({
    required this.id,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.knownFor,
  });
}
