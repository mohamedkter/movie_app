import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/utils/icons/app_icons.dart';
import 'package:movie_app/features/home/domain/entities/Movie_entity.dart';
import 'package:intl/intl.dart';

class MovieCard extends StatelessWidget {
  final MovieEntity? movie;

  const MovieCard({
    super.key,
    required this.movie,
  });

  String numberFormat(double? num) {
    var format = NumberFormat("#.#");
    return format.format(num);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/movieDetails', arguments: movie?.id);
      },
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://image.tmdb.org/t/p/w500${movie?.poster_path}"),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                width: 1)),
        width: MediaQuery.sizeOf(context).width * 0.4,
        child: Padding(
          padding: EdgeInsets.only(left: 2.r, right: 2.r, top: 60.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 35.r,
                    height: 35.r,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(8.r)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppIcons.display(
                        size: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8.r)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding:  EdgeInsets.all(5.r),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.34,
                              child: Text("${movie?.title}",
                                  softWrap: true,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textWidthBasis: TextWidthBasis.parent,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700)),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.34,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text("${movie?.popularity} View",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.w500,
                                              )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Row(
                                    children: [
                                      AppIcons.stars(
                                          size: 20, color: Colors.amber),
                                      Text(numberFormat(movie?.vote_average),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.w500,
                                              )),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
