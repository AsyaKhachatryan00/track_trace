import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trace/core/config/theme/app_colors.dart';
import 'package:track_trace/core/route/routes.dart';
import 'package:track_trace/features/quiz/widgets/play_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        leadingWidth: 0,
        titleSpacing: 0,
        centerTitle: false,
        title: Padding(
          padding: EdgeInsets.only(left: 24.w),
          child: Text(
            'Track Quest',
            style: Theme.of(
              context,
            ).textTheme.displayLarge?.copyWith(fontWeight: FontWeight.w400),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _decoration(
              () => Get.toNamed(
                RouteLink.play,
                id: 1,
                arguments: PlayModes.casual,
              ),
              Icons.play_arrow,
              AppColors.aquamarine,
              'Casual Mode',
              'No time limits or life restrictions,Perfect for learning!',
            ),
            _decoration(
              () => Get.toNamed(
                RouteLink.play,
                id: 1,
                arguments: PlayModes.survival,
              ),

              Icons.favorite,
              AppColors.alizarin,
              'Survival Mode',
              'Test your skills with limited lives. How far can you go?',
            ),
            _decoration(
              () => Get.toNamed(
                RouteLink.play,
                id: 1,
                arguments: PlayModes.timed,
              ),

              Icons.watch_later_rounded,
              AppColors.blue,
              'Timed Mode',
              'Race against time! How many can you identify in 60 seconds?',
            ),
          ],
        ),
      ),
    );
  }

  Widget _decoration(
    VoidCallback onTap,
    IconData icon,
    Color color,
    String title,
    String subtile,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 327.w,
        padding: EdgeInsets.symmetric(vertical: 16.18.h, horizontal: 19.59.w),
        decoration: BoxDecoration(
          color: AppColors.zucchini,
          borderRadius: BorderRadius.circular(8.r),
        ),
        margin: EdgeInsets.only(bottom: 16.h),
        child: Column(
          children: [
            Icon(icon, color: color, size: 34),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Text(
              subtile,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
      ),
    );
  }
}
