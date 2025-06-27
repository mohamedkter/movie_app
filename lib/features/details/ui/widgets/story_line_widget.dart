import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

class StorylineWidget extends StatelessWidget {
  final String storylineText;
  const StorylineWidget({
    super.key,
    required this.storylineText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Story Line",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 15,
                ),
          ),
          SizedBox(
            height: 15.h,
          ),
          ReadMoreText(
            storylineText,
            trimLength: 180,
            colorClickableText: Theme.of(context).colorScheme.primary,
          )
        ],
      ),
    );
  }
}
