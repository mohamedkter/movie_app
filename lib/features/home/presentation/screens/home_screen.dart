import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/utils/widgets/list_card_shimmer_loading_widget.dart';
import 'package:movie_app/core/utils/widgets/movie_card.dart';
import 'package:movie_app/features/home/presentation/bloc/trending_cubit.dart';
import 'package:movie_app/features/home/presentation/bloc/trending_people_cubit.dart';
import 'package:movie_app/features/home/presentation/bloc/trending_people_states.dart';
import 'package:movie_app/features/home/presentation/bloc/trending_states.dart';
import 'package:movie_app/features/home/presentation/bloc/upcoming_cubit.dart';
import 'package:movie_app/features/home/presentation/bloc/upcoming_states.dart';
import 'package:movie_app/features/home/presentation/widgets/custom_header.dart';
import 'package:movie_app/features/home/presentation/widgets/custom_search_widget.dart';

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
    context.read<TrendingPeopleCubit>().eitherFailureOrTrendingPeople();
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
      child: const SingleChildScrollView(
        child: Column(
          children: [
            CustomSearchWidget(),
            TrendingSection(),
            SizedBox(height: 20),
            TrendingMovieStarsSection(),
            SizedBox(height: 20),
            UpcomingSection(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class TrendingMovieStarsSection extends StatelessWidget {
  const TrendingMovieStarsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const CustomHeader(HeaderTitle: "Trending Movie Stars"),
          BlocBuilder<TrendingPeopleCubit, TrendingPeopleState>(
            builder: (context, state) {
              if (state is TrendingPeopleLoadingState) {
                return const ListCardShimmerLoadingWidget();
              } else if (state is TrendingPeopleSuccessState) {
                return Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: SizedBox(
                    height: 145.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.trendingPeople.length,
                      itemBuilder: (context, index) => SizedBox(
                        width: 120.w,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer
                                        .withOpacity(0.5),
                                    Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.2),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(100.r),
                                border: Border.all(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.5),
                                  width: 3,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CircleAvatar(
                                  radius: 50.r,
                                  backgroundImage: NetworkImage(
                                      "https://image.tmdb.org/t/p/w500${state.trendingPeople[index].profilePath}"),
                                ),
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              state.trendingPeople[index].name,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 16.w),
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
    );
  }
}

class TrendingSection extends StatelessWidget {
  const TrendingSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          const CustomHeader(HeaderTitle: "Trending Movies"),
          BlocBuilder<TrendingCubit, TrendingState>(
            builder: (context, state) {
              if (state is TrendingLoadingState) {
                return const ListCardShimmerLoadingWidget();
              } else if (state is TrendingSuccessState) {
                return Padding(
                  padding: EdgeInsets.only(top: 15.h),
                  child: SizedBox(
                    height: 200,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.trendingMovies.length,
                      itemBuilder: (context, index) =>
                          MovieCard(movie: state.trendingMovies[index]),
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 15.w),
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
    );
  }
}

class UpcomingSection extends StatelessWidget {
  const UpcomingSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  padding: EdgeInsets.only(top: 15.h),
                  child: SizedBox(
                    height: 200,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.upcomingMovies.length,
                      itemBuilder: (context, index) =>
                          MovieCard(movie: state.upcomingMovies[index]),
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 15.w),
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
    );
  }
}
