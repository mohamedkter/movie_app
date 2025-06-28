import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/router/app_routes.dart';
import 'package:movie_app/core/utils/icons/app_icons.dart';
import 'package:movie_app/features/view_more/actors/data/models/known_for_model.dart';


class KnownForMovieTile extends StatelessWidget {
  final KnownForModel movie;

  const KnownForMovieTile({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.movieDetails,
          arguments: movie.id,
        );
      },
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: movie.posterPath != null
              ? Image.network(
                  "https://image.tmdb.org/t/p/w200${movie.posterPath}",
                  height: 60,
                  width: 40,
                  fit: BoxFit.cover,
                )
              : const SizedBox.shrink(),
        ),
        title: Text(
          movie.title ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Row(
              children: [
                AppIcons.calender(
                  color: Theme.of(context).colorScheme.primary,
                  size: 15,
                ),
                SizedBox(width: 5.w),
                Text(
                  movie.releaseDate ?? '',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                AppIcons.flame(
                  color: Theme.of(context).colorScheme.primary,
                  size: 15,
                ),
                SizedBox(width: 5.w),
                Text(
                  movie.voteAverage?.toString() ?? '',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
