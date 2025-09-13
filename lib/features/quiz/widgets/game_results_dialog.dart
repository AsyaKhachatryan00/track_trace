import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:track_trace/core/config/constants/app_assets.dart';
import 'package:track_trace/core/config/theme/app_colors.dart';
import 'package:track_trace/core/route/routes.dart';
import 'package:track_trace/core/widgets/custom_button.dart';

class GameResults extends StatelessWidget {
  const GameResults({super.key, required this.count, required this.onTap});
  final String count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      backgroundColor: AppColors.black,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(79.5.w, 24.h, 79.5.w, 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: Color(0xFF0AA37C), size: 40),
            SizedBox(height: 23.h),
            Text(
              'Game Complete',
              style: Theme.of(
                context,
              ).textTheme.displayLarge?.copyWith(fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 8.h),
            Text(count, style: Theme.of(context).textTheme.displayLarge),
            SizedBox(height: 8.h),
            Text(
              'Correct Answers',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
                height: 1.5,
              ),
            ),
            SizedBox(height: 32.h),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomButton(
                  width: 56.w,
                  onTap: () {
                    Get.close(1);
                    onTap();
                  },
                  color: AppColors.white,
                  child: SvgPicture.asset(AppSvgs.tryAgain),
                ),
                SizedBox(width: 18.w),
                CustomButton(
                  onTap: () => Get
                    ..close(1)
                    ..offAllNamed(RouteLink.quiz, id: 1),
                  width: 56.w,
                  color: Color(0xFF0B8767),
                  child: SvgPicture.asset(AppSvgs.home),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
