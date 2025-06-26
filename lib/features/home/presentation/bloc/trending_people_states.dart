import 'package:movie_app/features/home/domain/entities/people_entity.dart';

abstract class TrendingPeopleState{}
class InitialState extends TrendingPeopleState {}
class TrendingPeopleLoadingState extends TrendingPeopleState {}
class TrendingPeopleSuccessState extends TrendingPeopleState {
  final List<PeopleEntity> trendingPeople;
  TrendingPeopleSuccessState({required this.trendingPeople});
}
class TrendingPeopleErrorState extends TrendingPeopleState {
  final String error;
  TrendingPeopleErrorState({required this.error});
} 