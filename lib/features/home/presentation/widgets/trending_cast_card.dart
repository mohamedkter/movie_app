
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/features/home/domain/entities/people_entity.dart';

class TrendingCastCard extends StatelessWidget {
 final  PeopleEntity people;
  const TrendingCastCard({
    super.key,
    required this.people,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120.w,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context)
                      .colorScheme
                      .secondaryContainer
                      .withOpacity(0.5),
                  Theme.of(context)
                      .colorScheme
                      .primary
                      .withOpacity(0.2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(100.r),
              border: Border.all(
                color: Theme.of(context)
                    .colorScheme
                    .primary
                    .withOpacity(0.5),
                width: 3,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: CircleAvatar(
                radius: 50.r,
                backgroundImage: NetworkImage(
                    "https://image.tmdb.org/t/p/w500${people.profilePath}"),
              ),
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            people.name,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}