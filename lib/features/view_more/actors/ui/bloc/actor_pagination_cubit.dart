import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/view_more/actors/domain/usecases/get_actors_usecase.dart';
import 'package:movie_app/features/view_more/actors/ui/bloc/actor_pagination_state.dart';

class ActorPaginationCubit extends Cubit<ActorPaginationState> {
  final GetActorsUseCase getActorsUseCase;

  int currentPage = 1;
  bool hasMore = true;

  ActorPaginationCubit(this.getActorsUseCase)
      : super(ActorPaginationInitial());

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
      (_) => emit(currentState.copyWith(isLoadingMore: false)),
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
