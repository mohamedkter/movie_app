import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/router/app_routes.dart';
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
import 'package:movie_app/features/home/presentation/widgets/trending_cast_card.dart';

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
           CustomHeader(headerTitle: "Trending Movie Stars",onViewMoreTab:(){
            Navigator.of(context).pushNamed(AppRoutes.viewMoreActorsScreen);
           }),
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
                      itemBuilder: (context, index) => TrendingCastCard(people: state.trendingPeople[index],),
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
           CustomHeader(headerTitle: "Trending Movies",onViewMoreTab:(){}),
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
          CustomHeader(headerTitle: "Upcoming Movies",onViewMoreTab:(){}),
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
