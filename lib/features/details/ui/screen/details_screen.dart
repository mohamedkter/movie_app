import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/utils/icons/app_icons.dart';
import 'package:movie_app/core/utils/widgets/list_card_shimmer_loading_widget.dart';
import 'package:movie_app/core/utils/widgets/movie_card.dart';
import 'package:movie_app/features/details/data/models/cast_model.dart';
import 'package:movie_app/features/details/domain/entities/details_movie_entity.dart';
import 'package:movie_app/features/details/ui/bloc/movie_details_cubit.dart';
import 'package:movie_app/features/details/ui/bloc/movie_details_states.dart';
import 'package:movie_app/features/details/ui/bloc/recommended_movies_cubit.dart';
import 'package:movie_app/features/details/ui/bloc/recommended_movies_state.dart';
import 'package:movie_app/features/details/ui/bloc/similar_movies_cubit.dart';
import 'package:movie_app/features/details/ui/bloc/similar_movies_state.dart';
import 'package:movie_app/features/details/ui/widgets/movie_trailer_widget.dart';
import 'package:movie_app/features/details/ui/widgets/story_line_widget.dart';
import 'package:movie_app/features/home/presentation/widgets/custom_header.dart';

class DetailsScreen extends StatefulWidget {
  final int movieId;
  const DetailsScreen({super.key, required this.movieId});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  DetailsMovieEntity? movieDetails;
  @override
  void initState() {
    super.initState();
    context.read<MovieDetailsCubit>().fetchMovieDetails(widget.movieId);
    context
        .read<RecommendedMoviesCubit>()
        .fetchRecommendedMovies(widget.movieId);
    context.read<SimilarMoviesCubit>().fetchSimilarMovies(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<MovieDetailsCubit, MovieDetailsStates>(
            builder: (context, state) {
          if (state is MovieDetailsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieDetailsSuccessState) {
            movieDetails = state.movieDetails;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MovieTrailerWidget(
                    is_Favorite: true, //is_Favorite,
                    IconButtonFunction: () {
                      setState(() {
                        //is_Favorite = !is_Favorite;
                      });
                    },
                    movieDetails: movieDetails,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  StorylineWidget(
                    storylineText: movieDetails == null
                        ? "overview"
                        : movieDetails?.overview ?? 'No overview available',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  movieDetails!.productionCompany != null &&
                          movieDetails!.productionCompany!.isNotEmpty
                      ? ProductionCompanySection(movieDetails: movieDetails)
                      : const SizedBox(
                          width: 0,
                        ),
                  const SizedBox(
                    height: 15,
                  ),
                  MovieCastSection(movieDetails: movieDetails),
                  const SizedBox(
                    height: 15,
                  ),
                  const SimilarMoviesSection(),
                  const SizedBox(
                    height: 15,
                  ),
                  const RecommendedMoviesSection(),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            );
          } else if (state is MovieDetailsErrorState) {
            return Center(
              child: Text(state.errorMessage),
            );
          }
          // Default widget in case none of the above conditions are met
          return const SizedBox.shrink();
        }));
  }
}

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
          const CustomHeader(HeaderTitle: "Recommended Movies"),
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
          const CustomHeader(HeaderTitle: "Similar Movies"),
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

class MovieCastSection extends StatelessWidget {
  const MovieCastSection({
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
          const SectionHeaderWithAnimation(),
          SizedBox(
            height: 15.h,
          ),
          SizedBox(
            height: 250.h,
            child: PageView.builder(
                itemCount: movieDetails?.cast?.length ?? 0,
                itemBuilder: (context, index) {
                  CastModel castMember = movieDetails!.cast![index];
                  return MovieCastCardWidget(castMember: castMember);
                }),
          ),
        ],
      ),
    );
  }
}

class MovieCastCardWidget extends StatelessWidget {
  const MovieCastCardWidget({
    super.key,
    required this.castMember,
  });

  final CastModel castMember;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
        image: DecorationImage(
          image: NetworkImage(
            "https://image.tmdb.org/t/p/w500${castMember.profile_path ?? ''}",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              castMember.name ?? 'Unknown',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
            ),
            SizedBox(height: 4.h),
            Text(
              castMember.character ?? 'Unknown Role',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 12.sp,
                    color: Colors.white70,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionHeaderWithAnimation extends StatefulWidget {
  const SectionHeaderWithAnimation({super.key});

  @override
  State<SectionHeaderWithAnimation> createState() =>
      _SectionHeaderWithAnimationState();
}

class _SectionHeaderWithAnimationState extends State<SectionHeaderWithAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<Offset> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    animation = Tween<Offset>(
      begin: const Offset(-0.2, 0), // start slightly off-screen to the left
      end: Offset.zero, // end at natural position
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ));

    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Movie Cast",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 15,
              ),
        ),
        SlideTransition(
          position: animation,
          child: Row(
            children: [
              Text(
                "Scroll  ",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
              ),
              AppIcons.roundedArrowRight(
                color: Theme.of(context).colorScheme.primary,
                size: 16, // remove `.w` if you're not using ScreenUtil
              ),
            ],
          ),
        ),
      ],
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
                                      image: NetworkImage(
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
