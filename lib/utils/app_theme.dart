import 'package:animelagoom/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static final ThemeData whiteTheme = ThemeData(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.whiteColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        iconTheme: IconThemeData(
          color: AppColors.orangeColor,
          
        ),
        titleTextStyle: AppStyles.regular16greyColorRoboto.copyWith(
          color: AppColors.orangeColor,
          fontWeight: FontWeight.w600,
        ),
      )
      );
}
