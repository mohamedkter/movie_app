import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/utils/icons/app_icons.dart';
import 'package:movie_app/features/details/data/models/genre.dart';
import 'package:movie_app/features/details/domain/entities/details_movie_entity.dart';
import 'package:movie_app/features/details/ui/screen/trailer_screen.dart';
import 'package:movie_app/features/details/ui/widgets/not_found_video_dialog.dart';

class MovieTrailerWidget extends StatefulWidget {
  final DetailsMovieEntity? movieDetails;
  final bool isFavorite;
  final VoidCallback iconButtonFunction;
  const MovieTrailerWidget({
    super.key,
    required this.isFavorite,
    required this.iconButtonFunction,
    required this.movieDetails,
  });

  @override
  State<MovieTrailerWidget> createState() => _MovieTrailerWidgetState();
}

class _MovieTrailerWidgetState extends State<MovieTrailerWidget> {
  String connectnetGenres(List<Genre> genres) {
    if (genres.isEmpty) return 'No Genres';
    return genres.map((genre) => genre.name).join(', ');
  }

  String handleRuntime(int? runtime) {
    if (runtime == null || runtime <= 0) return 'N/A';
    int hours = runtime ~/ 60;
    int minutes = runtime % 60;
    return '$hours hr ${minutes}min';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 450.h,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: CachedNetworkImageProvider(
                  "https://image.tmdb.org/t/p/w500${widget.movieDetails?.backdropPath ?? ''}"),
              fit: BoxFit.cover)),
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: AppIcons.roundedArrowLeft(
                        color: Theme.of(context).colorScheme.primary,
                        size: 30,
                      )),
                  IconButton(
                    onPressed: widget.iconButtonFunction,
                    icon: Icon(
                      widget.isFavorite == false
                          ? Icons.favorite_border
                          : Icons.favorite_rounded,
                      color: Theme.of(context).colorScheme.primary,
                      size: 30,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 165.662.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    if (widget.movieDetails?.videos != null &&
                        widget.movieDetails!.videos!.isNotEmpty) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TrailerScreen(
                            videos: widget.movieDetails!.videos!,
                          ),
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const NotFoundVideoDialog();
                        },
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(50),
                            bottomLeft: Radius.circular(50)),
                        color: const Color.fromARGB(255, 105, 104, 104)
                            .withOpacity(0.6)),
                    width: 200,
                    height: 60,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: AppIcons.play(
                            color: Theme.of(context).colorScheme.primary,
                            size: 40,
                          ),
                        ),
                        const Text(
                          "Watch Trailer",
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Container(
              width: double.infinity,
              height: 152,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black, Colors.black],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.movieDetails?.title ?? 'Movie Title',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Text(
                      connectnetGenres(widget.movieDetails?.genres ?? []),
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.grey.shade500, fontSize: 12),
                    ),
                  ),
                  Text(
                    "${widget.movieDetails?.originalLanguage?.toUpperCase() ?? 'N/A'}   |   ${handleRuntime(widget.movieDetails?.runtime)}",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.grey.shade500, fontSize: 12),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 50, vertical: 5.h),
                    child: const Divider(
                      thickness: 0.5,
                      endIndent: 0,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      "Release Date: ${widget.movieDetails?.releaseDate ?? 'N/A'}",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
