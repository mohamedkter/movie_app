import 'package:movie_app/features/details/data/models/cast_model.dart';
import 'package:movie_app/features/details/data/models/genre.dart';
import 'package:movie_app/features/details/data/models/production_company.dart';

class DetailsMovieEntity {
  final String? backdropPath;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? title;
  final String? originalLanguage;
  final double? voteAverage;
  final String? releaseDate;
  final int? runtime;
  final List<ProductionCompany>? productionCompany;
  final List<Genre>? genres;
  final List<CastModel>? cast;
  DetailsMovieEntity(
      {required this.backdropPath,
      required this.releaseDate,
      required this.genres, 
      required this.cast,
      required this.runtime,
      required this.productionCompany,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.title,
      required this.originalLanguage,
      required this.voteAverage});
}
