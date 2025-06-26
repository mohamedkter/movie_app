import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/widgets/loading_widget.dart';
import 'package:movie_app/core/utils/widgets/movie_card.dart';
import 'package:movie_app/features/home/presentation/bloc/home_cubit.dart';
import 'package:movie_app/features/home/presentation/bloc/home_states.dart';
import 'package:movie_app/features/home/presentation/widgets/custom_header.dart';
import 'package:movie_app/features/home/presentation/widgets/custom_search_widget.dart';
import 'package:movie_app/movie_app.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = true;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(context).eitherFailureOrHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      if (state is HomeSuccessState) {
        return Container(
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Theme.of(context).colorScheme.secondaryContainer, Theme.of(context).colorScheme.secondary],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CustomSearchWidget(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const CustomHeader(
                        HeaderTitle: "Trending Movies",
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: SizedBox(
                          height: 200,
                          child: ListView.separated(
                              itemCount: state.trendingMovies.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) =>
                                  MovieCard(movie: state.trendingMovies[index]),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 16),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const CustomHeader(
                        HeaderTitle: "Upcoming Movies",
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: SizedBox(
                          height: 200,
                          child: ListView.separated(
                            itemCount: state.upcomingMovies.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) =>
                                MovieCard(movie: state.upcomingMovies[index]),
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 16),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      } else if (state is HomeLoadingState) {
        return const LoadingWidget();
      } else {
        return Text("Error: ${state.toString()}");
      }
    });
  }
}
