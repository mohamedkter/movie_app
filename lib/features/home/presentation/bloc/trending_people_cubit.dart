import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/api/dio_consumer.dart';
import 'package:movie_app/core/cache/cache_helper.dart';
import 'package:movie_app/core/connection/network_info.dart';
import 'package:movie_app/features/home/data/datasources/home_local_datasource.dart';
import 'package:movie_app/features/home/data/datasources/home_remote_datasource.dart';
import 'package:movie_app/features/home/data/repo/home_repository_impl.dart';
import 'package:movie_app/features/home/domain/entities/people_entity.dart';
import 'package:movie_app/features/home/domain/usecases/get_trending_persone.dart';
import 'package:movie_app/features/home/presentation/bloc/trending_people_states.dart';



class TrendingPeopleCubit extends Cubit<TrendingPeopleState> {
  TrendingPeopleCubit() : super(InitialState());

  eitherFailureOrTrendingPeople() async {
  emit(TrendingPeopleLoadingState());

  final repository = HomeRepositoryImpl(
    remoteDataSource: HomeRemoteDataSource(api: DioConsumer(dio: Dio())),
    localDataSource: HomeLocalDataSource(cache: CacheHelper()),
    networkInfo: NetworkInfoImpl(DataConnectionChecker()),
  );

  final trendingPeopleResult = await GetTrendingPerson(repository: repository).call();
  

  if (trendingPeopleResult.isLeft()) {
    trendingPeopleResult.fold(
      (failure) => emit(TrendingPeopleErrorState(error: failure.errMessage)),
      (_) {},
    );
    return;
  }

  final trendingPeople = trendingPeopleResult.fold<List<PeopleEntity>>((l) => <PeopleEntity>[], (r) => r);
 

  emit(TrendingPeopleSuccessState(
    trendingPeople: trendingPeople,
  ));
}
}
