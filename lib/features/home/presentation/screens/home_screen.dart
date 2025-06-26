import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/widgets/loading_widget.dart';
import 'package:movie_app/core/utils/widgets/movie_card.dart';
import 'package:movie_app/core/utils/widgets/movie_card_skeleton.dart';
import 'package:movie_app/features/home/domain/entities/Movie_entity.dart';
import 'package:movie_app/features/home/presentation/bloc/trending_cubit.dart';
import 'package:movie_app/features/home/presentation/bloc/trending_states.dart';
import 'package:movie_app/features/home/presentation/bloc/upcoming_cubit.dart';
import 'package:movie_app/features/home/presentation/bloc/upcoming_states.dart';
import 'package:movie_app/features/home/presentation/widgets/custom_header.dart';
import 'package:movie_app/features/home/presentation/widgets/custom_search_widget.dart';
import 'package:movie_app/movie_app.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TrendingCubit>().eitherFailureOrTrending();
    context.read<UpcomingCubit>().eitherFailureOrUpcoming();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.secondaryContainer,
            Theme.of(context).colorScheme.secondary
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const CustomSearchWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const CustomHeader(HeaderTitle: "Trending Movies"),
                  BlocBuilder<TrendingCubit, TrendingState>(
                    builder: (context, state) {
                      if (state is TrendingLoadingState) {
                        return const ListCardShimmerLoadingWidget();
                      } else if (state is TrendingSuccessState) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: SizedBox(
                            height: 200,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.trendingMovies.length,
                              itemBuilder: (context, index) =>
                                  MovieCard(movie: state.trendingMovies[index]),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 16),
                            ),
                          ),
                        );
                      } else {
                        return const Text("Failed to load trending movies.");
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const CustomHeader(HeaderTitle: "Upcoming Movies"),
                  BlocBuilder<UpcomingCubit, UpcomingStates>(
                    builder: (context, state) {
                      if (state is UpcomingLoadingState) {
                        return const ListCardShimmerLoadingWidget();
                      } else if (state is UpcomingSuccessState) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: SizedBox(
                            height: 200,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.upcomingMovies.length,
                              itemBuilder: (context, index) =>
                                  MovieCard(movie: state.upcomingMovies[index]),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 16),
                            ),
                          ),
                        );
                      } else {
                        return const Text("Failed to load upcoming movies.");
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ListCardShimmerLoadingWidget extends StatelessWidget {
  const ListCardShimmerLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      containersColor: Theme.of(context).colorScheme.primary,
     enableSwitchAnimation: true ,
      enabled: true,
      child: Padding(
      padding: const EdgeInsets.only(top: 15),
      child: SizedBox(
        height: 200,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, index) =>
             const MovieCardSkeleton(),
          separatorBuilder: (context, index) =>
              const SizedBox(width: 16),
        ),
      ),
    )
    );
  }
}
