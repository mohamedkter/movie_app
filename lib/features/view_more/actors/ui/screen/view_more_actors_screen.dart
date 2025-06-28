import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/utils/widgets/custom_appBar.dart';
import 'package:movie_app/features/view_more/actors/ui/bloc/actor_pagination_cubit.dart';
import 'package:movie_app/features/view_more/actors/ui/bloc/actor_pagination_state.dart';
import 'package:movie_app/features/view_more/actors/ui/widgets/actor_card.dart';


class ViewMoreActorsScreen extends StatefulWidget {
  const ViewMoreActorsScreen({super.key});

  @override
  State<ViewMoreActorsScreen> createState() => _ViewMoreActorsScreenState();
}

class _ViewMoreActorsScreenState extends State<ViewMoreActorsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ActorPaginationCubit>().fetchInitialActors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Movies Stars"),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 300) {
            context.read<ActorPaginationCubit>().fetchMoreActors();
          }
          return false;
        },
        child: BlocBuilder<ActorPaginationCubit, ActorPaginationState>(
          builder: (context, state) {
            if (state is ActorPaginationLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ActorPaginationLoaded) {
              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: state.actors.length + (state.isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < state.actors.length) {
                    return ActorCard(actor: state.actors[index]);
                  } else {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              );
            } else if (state is ActorPaginationError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
