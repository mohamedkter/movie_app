

import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/icons/app_icons.dart';

class SectionHeaderWithAnimation extends StatefulWidget {
  const SectionHeaderWithAnimation({super.key});

  @override
  State<SectionHeaderWithAnimation> createState() =>
      _SectionHeaderWithAnimationState();
}

class _SectionHeaderWithAnimationState extends State<SectionHeaderWithAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<Offset> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    animation = Tween<Offset>(
      begin: const Offset(-0.2, 0), // start slightly off-screen to the left
      end: Offset.zero, // end at natural position
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ));

    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Movie Cast",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 15,
              ),
        ),
        SlideTransition(
          position: animation,
          child: Row(
            children: [
              Text(
                "Scroll  ",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
              ),
              AppIcons.roundedArrowRight(
                color: Theme.of(context).colorScheme.primary,
                size: 16, // remove `.w` if you're not using ScreenUtil
              ),
            ],
          ),
        ),
      ],
    );
  }
}