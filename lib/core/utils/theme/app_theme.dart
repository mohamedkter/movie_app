import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/utils/theme/app_color.dart';

 final ThemeData  darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: AppColorDark.primary,
    secondary: AppColorDark.secondary,
    secondaryContainer: AppColorDark.secondaryVariant,
  ),
  useMaterial3: true,
  textTheme:  TextTheme(
    bodyLarge:TextStyle(fontFamily: "Michroma" , fontSize: 16.sp ),
    bodyMedium:TextStyle(fontFamily: "Michroma" , fontSize: 12.sp ),
    bodySmall:TextStyle(fontFamily: "Michroma" , fontSize: 8.sp ),
  ),
);