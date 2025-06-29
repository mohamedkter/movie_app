import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/home/domain/usecases/get_trending_persone.dart';
import 'package:movie_app/features/home/presentation/bloc/trending_people_states.dart';

class TrendingPeopleCubit extends Cubit<TrendingPeopleState> {
  final GetTrendingPerson getTrendingPerson;

  TrendingPeopleCubit(this.getTrendingPerson) : super(InitialState());

  Future<void> eitherFailureOrTrendingPeople() async {
    emit(TrendingPeopleLoadingState());

    final trendingPeopleResult = await getTrendingPerson.call();

    trendingPeopleResult.fold(
      (failure) => emit(TrendingPeopleErrorState(error: failure.errMessage)),
      (trendingPeople) => emit(TrendingPeopleSuccessState(trendingPeople: trendingPeople)),
    );
  }
}
