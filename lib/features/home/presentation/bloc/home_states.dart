import 'package:movie_app/features/home/domain/entities/Movie_entity.dart';

abstract class HomeState{}
class HomeInitialState extends HomeState {}
class HomeLoadingState extends HomeState {}
class HomeSuccessState extends HomeState {
  final List<MovieEntity> trendingMovies;
  final List<MovieEntity> upcomingMovies;
  HomeSuccessState({required this.trendingMovies, required this.upcomingMovies});
}
class HomeErrorState extends HomeState {
  final String error;
  HomeErrorState({required this.error});
} 