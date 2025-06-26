import 'package:movie_app/features/home/domain/entities/Movie_entity.dart';

abstract class UpcomingStates{}
class InitialState extends UpcomingStates {}
class UpcomingLoadingState extends UpcomingStates {}
class UpcomingSuccessState extends UpcomingStates {
  final List<MovieEntity> upcomingMovies;
  UpcomingSuccessState({required this.upcomingMovies});
}
class UpcomingErrorState extends UpcomingStates {
  final String error;
  UpcomingErrorState({required this.error});
} 