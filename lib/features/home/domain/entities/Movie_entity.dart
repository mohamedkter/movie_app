class MovieEntity {
  final int id;
  final String? title;
  final String? poster_path;
  final double? popularity;
  final double? vote_average;

  MovieEntity({
    required this.id,
    required this.title,
    required this.poster_path,
    required this.popularity,
    required this.vote_average,
  });
}
