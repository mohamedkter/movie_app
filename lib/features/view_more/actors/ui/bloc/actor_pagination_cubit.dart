import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/api/dio_consumer.dart';
import 'package:movie_app/core/connection/network_info.dart';
import 'package:movie_app/features/view_more/actors/data/datasources/actor_remote_dataSource.dart';
import 'package:movie_app/features/view_more/actors/data/repo/actor_repository_Impl.dart';
import 'package:movie_app/features/view_more/actors/domain/usecases/get_actors_usecase.dart';

import 'actor_pagination_state.dart';

class ActorPaginationCubit extends Cubit<ActorPaginationState> {

 final actorRepository = ActorRepositoryImpl(
  remoteDataSource: ActorRemoteDataSourceImpl(api: DioConsumer(dio: Dio())),
  networkInfo: NetworkInfoImpl(DataConnectionChecker()),
);
  late final GetActorsUseCase getActorsUseCase;

  int currentPage = 1;
  bool hasMore = true;

  ActorPaginationCubit()
      : super(ActorPaginationInitial()) {
    getActorsUseCase = GetActorsUseCase(actorRepository);
  }

  Future<void> fetchInitialActors() async {
    emit(ActorPaginationLoading());
    currentPage = 1;
    final result = await getActorsUseCase.call(page: currentPage);
    result.fold(
      (failure) => emit(ActorPaginationError(failure.errMessage)),
      (actors) {
        hasMore = actors.length >= 20;
        emit(ActorPaginationLoaded(
          actors: actors,
          hasMore: hasMore,
        ));
      },
    );
  }

  Future<void> fetchMoreActors() async {
    if (state is! ActorPaginationLoaded || !hasMore) return;

    final currentState = state as ActorPaginationLoaded;
    emit(currentState.copyWith(isLoadingMore: true));

    currentPage++;
    final result = await getActorsUseCase.call(page: currentPage);

    result.fold(
      (failure) {
        emit(currentState.copyWith(isLoadingMore: false));
      },
      (newActors) {
        hasMore = newActors.length >= 20;
        emit(ActorPaginationLoaded(
          actors: currentState.actors + newActors,
          hasMore: hasMore,
        ));
      },
    );
  }
}
