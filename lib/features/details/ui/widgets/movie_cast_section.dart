
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/features/details/data/models/cast_model.dart';
import 'package:movie_app/features/details/domain/entities/details_movie_entity.dart';
import 'package:movie_app/features/details/ui/widgets/movie_cast_card_widget.dart';
import 'package:movie_app/features/details/ui/widgets/section_header_with_animation.dart';

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