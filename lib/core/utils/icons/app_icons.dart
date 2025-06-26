import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcons {
  static Widget home({double size = 24.0, Color? color}) {
    return SvgPicture.asset(
      'assets/icons/home_icon.svg',
      width: size,
      height: size,
      color: color,
    );
  }

  static Widget search({double size = 24.0, Color? color}) {
    return SvgPicture.asset(
      'assets/icons/magnifier-icon.svg',
      width: size,
      height: size,
      color: color,
    );
  }

  static Widget favorite({double size = 24.0, Color? color}) {
    return SvgPicture.asset(
      'assets/icons/clipboard-heart-icon.svg',
      width: size,
      height: size,
      color: color,
    );
  }

  static Widget profile({double size = 24.0, Color? color}) {
    return SvgPicture.asset(
      'assets/icons/user-icon.svg',
      width: size,
      height: size,
      color: color,
    );
  }

  static Widget display({double size = 24.0, Color? color}) {
    return SvgPicture.asset(
      'assets/icons/display-icon.svg',
      width: size,
      height: size,
      color: color,
    );
  }
  static Widget stars({double size = 24.0, Color? color}) {
    return SvgPicture.asset(
      'assets/icons/stars-minimalistic-icon.svg',
      width: size,
      height: size,
      color: color,
    );
  }
}
