import 'package:movie_app/features/home/domain/entities/Movie_entity.dart';

class MovieModel extends MovieEntity {
  final int id;
  final String? title;
  final String? original_title;
  final String? poster_path;
  final double? popularity;
  final String? original_language;
  final bool? video;
  final String? release_date;
  final String? backdrop_path;
  final double? vote_average;

  MovieModel(
      {required this.id,
      this.title,
      this.poster_path,
      this.original_title,
      this.popularity,
      this.video,
      this.release_date,
      this.backdrop_path,
      this.vote_average,
      this.original_language})
      : super(
            id: id,
            title: title,
            poster_path: poster_path,
            popularity: popularity,
            vote_average: vote_average,
            original_language: original_language,
            original_title: original_title
            );

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
        id: map['id'],
        title: map['title'],
        poster_path: map['poster_path'],
        popularity: map['popularity'],
        video: map['video'] == 1,
        release_date: map['release_date'],
        backdrop_path: map['backdrop_path'],
        vote_average: map['vote_average'],
        original_title: map['original_title'],
        original_language: map['original_language']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'poster_path': poster_path,
      'popularity': popularity,
      'video': video,
      'release_date': release_date,
      'backdrop_path': backdrop_path,
      'vote_average': vote_average,
      'original_language': original_language,
      'original_title': original_title
    };
  }
}
