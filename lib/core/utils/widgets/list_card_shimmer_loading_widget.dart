
import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/widgets/movie_card_skeleton.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ListCardShimmerLoadingWidget extends StatelessWidget {
  const ListCardShimmerLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      containersColor: Theme.of(context).colorScheme.primary,
     enableSwitchAnimation: true ,
      enabled: true,
      child: Padding(
      padding: const EdgeInsets.only(top: 15),
      child: SizedBox(
        height: 200,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, index) =>
             const MovieCardSkeleton(),
          separatorBuilder: (context, index) =>
              const SizedBox(width: 16),
        ),
      ),
    )
    );
  }
}
