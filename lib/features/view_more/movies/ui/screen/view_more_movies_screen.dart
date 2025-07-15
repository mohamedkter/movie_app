import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/enums/movie_section.dart';
import 'package:movie_app/core/router/app_routes.dart';
import 'package:movie_app/core/utils/icons/app_icons.dart';
import 'package:movie_app/core/utils/widgets/custom_appBar.dart';
import 'package:movie_app/features/home/domain/entities/Movie_entity.dart';
import 'package:movie_app/features/view_more/movies/ui/bloc/view_more_movies_cubit.dart';
import 'package:movie_app/features/view_more/movies/ui/bloc/view_more_movies_state.dart';

class ViewMoreMoviesScreen extends StatefulWidget {
  final MovieSection section;

  const ViewMoreMoviesScreen({super.key, required this.section});

  @override
  State<ViewMoreMoviesScreen> createState() => _ViewMoreMoviesScreenState();
}

class _ViewMoreMoviesScreenState extends State<ViewMoreMoviesScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    context.read<ViewMoreMoviesCubit>().fetchMovies(widget.section);
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<ViewMoreMoviesCubit>().fetchMoreMovies();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.section.name,
      ),
      body: BlocBuilder<ViewMoreMoviesCubit, ViewMoreMoviesState>(
        builder: (context, state) {
          if (state is ViewMoreMoviesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ViewMoreMoviesSuccess) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.movies.length + (state.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= state.movies.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final movie = state.movies[index];
                return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 6),
                    child: LargeMovieCard(
                      movie: movie,
                    ));
              },
            );
          } else if (state is ViewMoreMoviesError) {
            return Center(child: Text("❌ ${state.error}"));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class LargeMovieCard extends StatelessWidget {
  const LargeMovieCard({super.key, required this.movie});
  final MovieEntity movie;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(AppRoutes.movieDetails,arguments: movie.id);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 3,
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 3,
              height: 160.h,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(12.r),
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          "https://image.tmdb.org/t/p/w500${movie.poster_path}"),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              height: 160.h,
              width: MediaQuery.of(context).size.width / 1.8,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: movie.original_language == 'en'
                              ? Colors.green
                              : Colors.orange,
                          borderRadius: BorderRadius.circular(8.r)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 3),
                        child: Text(movie.original_language ?? ''),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          movie.title ?? "Movie Name",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w700),
                          overflow: TextOverflow.ellipsis,
                        )),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        AppIcons.flame(
                            color: Theme.of(context).colorScheme.primary,
                            size: 24),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          "${movie.popularity} View",
                          style: Theme.of(context).textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        AppIcons.stars(color: Colors.amber, size: 24),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          movie.vote_average.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
