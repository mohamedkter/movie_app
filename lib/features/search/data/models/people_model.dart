import 'package:movie_app/features/home/domain/entities/people_entity.dart';

class PeopleModel extends PeopleEntity {
  final int id;
  final String name;
  final String? profilePath;
  final String? knownForDepartment;
  final double popularity;

  PeopleModel({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.knownForDepartment,
    required this.popularity,
  }) : super(
          id: id,
          name: name,
          profilePath: profilePath,
        );

  factory PeopleModel.fromJson(Map<String, dynamic> json) {
    return PeopleModel(
      id: json['id'],
      name: json['name'],
      profilePath: json['profile_path'],
      knownForDepartment: json['known_for_department'],
      popularity: (json['popularity'] as num).toDouble(),
    );
  }
Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'profile_path': profilePath,
      'known_for_department': knownForDepartment,
      'popularity': popularity,
    };
  }
}

