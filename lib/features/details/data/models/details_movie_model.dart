import 'package:movie_app/features/details/data/models/cast_model.dart';
import 'package:movie_app/features/details/data/models/genre.dart';
import 'package:movie_app/features/details/data/models/production_company.dart';
import 'package:movie_app/features/details/data/models/production_country.dart';
import 'package:movie_app/features/details/data/models/spoken_language.dart';
import 'package:movie_app/features/details/domain/entities/details_movie_entity.dart';

class DetailsMovieModel extends DetailsMovieEntity {
  final bool adult;
  final String? backdropPath;
  final int budget;
  final List<Genre> genres;
  final String homepage;
  final int id;
  final String imdbId;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
  final List<CastModel>? cast;

  DetailsMovieModel({
    required this.adult,
    required this.backdropPath,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.cast,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  }) : super(
          backdropPath: backdropPath,
          overview: overview,
          releaseDate: releaseDate,
          productionCompany: productionCompanies,
          popularity: popularity,
          posterPath: posterPath,
          title: title,
          originalLanguage: originalLanguage,
          voteAverage: voteAverage,
          genres: genres,
          runtime: runtime
          , cast: cast,
        );

  factory DetailsMovieModel.fromJson(Map<String, dynamic> json,Map<String, dynamic> castJson,) {
    return DetailsMovieModel(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      budget: json['budget'],
      cast:castJson['cast'] != null
          ? (castJson['cast'] as List)
              .map((e) => CastModel.fromJson(e))
              .toList()
          : null,
      genres: (json['genres'] as List)
          .map((e) => Genre.fromJson(e))
          .toList(),
      homepage: json['homepage'],
      id: json['id'],
      imdbId: json['imdb_id'],
      originCountry: List<String>.from(json['origin_country']),
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: (json['popularity'] as num).toDouble(),
      posterPath: json['poster_path'],
      productionCompanies: (json['production_companies'] as List)
          .map((e) => ProductionCompany.fromJson(e))
          .toList(),
      productionCountries: (json['production_countries'] as List)
          .map((e) => ProductionCountry.fromJson(e))
          .toList(),
      releaseDate: json['release_date'],
      revenue: json['revenue'],
      runtime: json['runtime'],
      spokenLanguages: (json['spoken_languages'] as List)
          .map((e) => SpokenLanguage.fromJson(e))
          .toList(),
      status: json['status'],
      tagline: json['tagline'],
      title: json['title'],
      video: json['video'],
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'budget': budget,
      'genres': genres.map((e) => e.toJson()).toList(),
      'homepage': homepage,
      'id': id,
      'imdb_id': imdbId,
      'origin_country': originCountry,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'production_companies':
          productionCompanies.map((e) => e.toJson()).toList(),
      'production_countries':
          productionCountries.map((e) => e.toJson()).toList(),
      'release_date': releaseDate,
      'revenue': revenue,
      'runtime': runtime,
      'spoken_languages':
          spokenLanguages.map((e) => e.toJson()).toList(),
      'status': status,
      'tagline': tagline,
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }
}