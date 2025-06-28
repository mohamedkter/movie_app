import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/features/details/data/models/cast_model.dart';

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
