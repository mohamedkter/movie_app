import 'package:movie_app/features/details/domain/entities/details_movie_entity.dart';

abstract class MovieDetailsStates {}
class MovieDetailsInitialState extends MovieDetailsStates {}
class MovieDetailsLoadingState extends MovieDetailsStates {}
class MovieDetailsSuccessState extends MovieDetailsStates {
  final DetailsMovieEntity movieDetails;
  MovieDetailsSuccessState({required this.movieDetails});
}
class MovieDetailsErrorState extends MovieDetailsStates {
  final String errorMessage;
  MovieDetailsErrorState({required this.errorMessage});
}
