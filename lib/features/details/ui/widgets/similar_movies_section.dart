import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/utils/widgets/list_card_shimmer_loading_widget.dart';
import 'package:movie_app/core/utils/widgets/movie_card.dart';
import 'package:movie_app/features/details/ui/bloc/similar_movies_cubit.dart';
import 'package:movie_app/features/details/ui/bloc/similar_movies_state.dart';
import 'package:movie_app/features/home/presentation/widgets/custom_header.dart';

class SimilarMoviesSection extends StatelessWidget {
  const SimilarMoviesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
           CustomHeader(headerTitle: "Similar Movies",onViewMoreTab:(){}),
          BlocBuilder<SimilarMoviesCubit, SimilarMoviesState>(
            builder: (context, state) {
              if (state is SimilarMoviesLoadingState) {
                return const ListCardShimmerLoadingWidget();
              } else if (state is SimilarMoviesSuccessState) {
                return Padding(
                  padding: EdgeInsets.only(top: 15.h),
                  child: SizedBox(
                    height: 200,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.movies.length,
                      itemBuilder: (context, index) =>
                          MovieCard(movie: state.movies[index]),
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