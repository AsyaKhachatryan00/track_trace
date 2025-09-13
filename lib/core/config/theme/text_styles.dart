import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_trace/core/config/theme/app_colors.dart';

final class AppTextStyle {
  AppTextStyle._();

  static TextStyle headlineLarge = TextStyle(
    fontFamily: 'BalooBhai',
    fontWeight: FontWeight.w400,
    fontSize: 32.sp,
    height: 1.5,
    letterSpacing: 0,
    color: AppColors.white,
  );

  static TextStyle headlineMedium = GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w500,
    fontSize: 18.sp,
    height: 1.5,
    letterSpacing: 0,
    color: AppColors.white,
  );

  static TextStyle headlineSmall = GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
    height: 1.2,
    letterSpacing: 0,
    color: AppColors.white,
  );

  static TextStyle displayLarge = TextStyle(
    fontFamily: 'BalooBhai',
    fontWeight: FontWeight.w600,
    fontSize: 24.sp,
    height: 1.5,
    letterSpacing: 0,
    color: AppColors.white,
  );

  static TextStyle displayMedium = GoogleFonts.balooBhaijaan2(
    fontWeight: FontWeight.w500,
    fontSize: 18.sp,
    height: 1.5,
    letterSpacing: 0,
    color: AppColors.white,
  );

  static TextStyle displaySmall = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    height: 1.5,
    letterSpacing: 0,
    color: AppColors.white.withValues(alpha: 0.68),
  );

  static TextStyle titleMedium = TextStyle(
    fontFamily: 'SfPro',
    fontWeight: FontWeight.w600,
    fontSize: 17.sp,
    height: 22 / 17,
    letterSpacing: -0.41,
    color: AppColors.black,
  );
}
