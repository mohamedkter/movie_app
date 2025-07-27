import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/router/app_routes.dart';
import 'package:movie_app/core/utils/icons/app_icons.dart';
import 'package:movie_app/features/home/domain/entities/Movie_entity.dart';

class FavoritesMovieCard extends StatelessWidget {
  const FavoritesMovieCard({super.key, required this.movie, required this.onDeleteTap});
  final MovieEntity movie;
  final VoidCallback onDeleteTap;
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        InkWell(
                          onTap:onDeleteTap,
                          child: AppIcons.trash(color: Colors.red,size: 30))
                      ],
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