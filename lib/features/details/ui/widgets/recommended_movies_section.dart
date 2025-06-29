
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/utils/widgets/list_card_shimmer_loading_widget.dart';
import 'package:movie_app/core/utils/widgets/movie_card.dart';
import 'package:movie_app/features/details/domain/entities/details_movie_entity.dart';
import 'package:movie_app/features/details/ui/bloc/recommended_movies_cubit.dart';
import 'package:movie_app/features/details/ui/bloc/recommended_movies_state.dart';
import 'package:movie_app/features/home/presentation/widgets/custom_header.dart';

class RecommendedMoviesSection extends StatelessWidget {
  const RecommendedMoviesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
           CustomHeader(headerTitle: "Recommended Movies",onViewMoreTab:(){}),
          BlocBuilder<RecommendedMoviesCubit, RecommendedMoviesState>(
            builder: (context, state) {
              if (state is RecommendedMoviesLoadingState) {
                return const ListCardShimmerLoadingWidget();
              } else if (state is RecommendedMoviesSuccessState) {
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



class ProductionCompanySection extends StatelessWidget {
  const ProductionCompanySection({
    super.key,
    required this.movieDetails,
  });

  final DetailsMovieEntity? movieDetails;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Production Companies",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 15,
                ),
          ),
          SizedBox(
            height: 15.h,
          ),
          SizedBox(
            height: 58.h, // Adjust height as needed
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: movieDetails!.productionCompany!.length,
              itemBuilder: (context, index) {
                final company = movieDetails!.productionCompany![index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8.w),
                    border: Border.all(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.2),
                      width: 1.w,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        company.logoPath != null
                            ? Container(
                                width: 50.r,
                                height: 50.r,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2.r),
                                    color: Colors.grey,
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          "https://image.tmdb.org/t/p/w500${company.logoPath}"),
                                      fit: BoxFit.cover,
                                    )),
                              )
                            : Icon(
                                Icons.business,
                                size: 24.w,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        SizedBox(width: 10.w),
                        Text(company.name,
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                width: 15.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
