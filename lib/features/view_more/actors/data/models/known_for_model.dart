class KnownForModel {
  final int id;
  final String title;
  final String posterPath;
  final String overview;
  final double voteAverage;
  final String releaseDate;

  KnownForModel({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.voteAverage,
    required this.releaseDate,
  });

  factory KnownForModel.fromJson(Map<String, dynamic> json) {
    return KnownForModel(
      id: json['id'],
      title: json['title'] ?? json['original_title'] ?? '',
      posterPath: json['poster_path'] ?? '',
      overview: json['overview'] ?? '',
      voteAverage: (json['vote_average'] as num).toDouble(),
      releaseDate: json['release_date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
      'overview': overview,
      'vote_average': voteAverage,
      'release_date': releaseDate,
    };
  }
}
