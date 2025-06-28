import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/icons/app_icons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackTap;
  final Color? backgroundColor;
  final Color? iconColor;
  final double elevation;
  final TextStyle? titleStyle;
  final bool centerTitle;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBackTap,
    this.backgroundColor = Colors.transparent,
    this.iconColor = Colors.white,
    this.elevation = 0,
    this.titleStyle,
    this.centerTitle = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      centerTitle: centerTitle,
      title: Text(
        title,
        style: titleStyle ?? Theme.of(context).textTheme.bodyLarge,
      ),
      leading: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: AppIcons.roundedArrowLeft(
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
        ),
      ),
    );
  }
}
