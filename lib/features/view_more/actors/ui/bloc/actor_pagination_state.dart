abstract class ActorPaginationState {}

class ActorPaginationInitial extends ActorPaginationState {}

class ActorPaginationLoading extends ActorPaginationState {}

class ActorPaginationLoaded extends ActorPaginationState {
  final List actors;
  final bool hasMore;
  final bool isLoadingMore;

  ActorPaginationLoaded({
    required this.actors,
    required this.hasMore,
    this.isLoadingMore = false,
  });

  ActorPaginationLoaded copyWith({
    List? actors,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return ActorPaginationLoaded(
      actors: actors ?? this.actors,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class ActorPaginationError extends ActorPaginationState {
  final String message;

  ActorPaginationError(this.message);
}
