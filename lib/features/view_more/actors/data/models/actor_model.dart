

import 'package:movie_app/features/view_more/actors/data/models/known_for_model.dart';
import 'package:movie_app/features/view_more/actors/domain/entities/actor_entity.dart';

class ActorModel extends ActorEntity {
  final int id;
  final String name;
  final String originalName;
  final String? profilePath;
  final String? knownForDepartment;
  final double popularity;
  final List<KnownForModel> knownFor;

  ActorModel({
    required this.id,
    required this.name,
    required this.originalName,
    required this.profilePath,
    required this.knownForDepartment,
    required this.popularity,
    required this.knownFor,
  }) : super(
          id: id,
          name: name,
          originalName: originalName,
          profilePath: profilePath,
          popularity: popularity,
          knownFor: knownFor,
        );

  factory ActorModel.fromJson(Map<String, dynamic> json) {
    return ActorModel(
      id: json['id'],
      name: json['name'],
      originalName: json['original_name'],
      profilePath: json['profile_path'],
      knownForDepartment: json['known_for_department'],
      popularity: (json['popularity'] as num).toDouble(),
      knownFor: (json['known_for'] as List<dynamic>)
          .map((item) => KnownForModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'original_name': originalName,
      'profile_path': profilePath,
      'known_for_department': knownForDepartment,
      'popularity': popularity,
      'known_for': knownFor.map((item) => item.toJson()).toList(),
    };
  }
}
