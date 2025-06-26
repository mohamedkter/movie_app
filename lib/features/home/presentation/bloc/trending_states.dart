import 'package:movie_app/features/home/domain/entities/Movie_entity.dart';

abstract class TrendingState{}
class InitialState extends TrendingState {}
class TrendingLoadingState extends TrendingState {}
class TrendingSuccessState extends TrendingState {
  final List<MovieEntity> trendingMovies;
  TrendingSuccessState({required this.trendingMovies});
}
class TrendingErrorState extends TrendingState {
  final String error;
  TrendingErrorState({required this.error});
} 