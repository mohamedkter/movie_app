class MovieEntity {
  final int id;
  final String? title;
  final String? poster_path;
  final double? popularity;
  final double? vote_average;
  final String? original_language;

  MovieEntity({
    required this.id,
    this.title,
    this.poster_path,
    this.popularity,
    this.vote_average,
    this.original_language
  });
}
