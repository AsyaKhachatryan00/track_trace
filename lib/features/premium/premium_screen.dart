import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:track_trace/core/config/constants/app_assets.dart';
import 'package:track_trace/core/config/theme/app_colors.dart';
import 'package:track_trace/core/widgets/custom_button.dart';
import 'package:track_trace/features/main/controller/main_controller.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.isRegistered()
        ? Get.find<MainController>()
        : Get.put(MainController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.only(left: 24.w),
          child: InkWell(
            onTap: () => Get.back(),
            child: SvgPicture.asset(
              AppSvgs.left,
              width: 30.w,
              height: 30.h,
              fit: BoxFit.none,
            ),
          ),
        ),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.settings),
            opacity: 0.2,
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 32.h, top: 8.h),
                  child: Text(
                    'Why Your Support Matters',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineLarge?.copyWith(height: 1.3),
                  ),
                ),
                _matters(context),
                Column(
                  children: [
                    CustomButton(
                      width: 327.w,
                      onTap: controller.setPremium,
                      data: 'Support for \$0,49',
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: CustomButton(
                        width: 327.w,
                        data: 'Restore',
                        color: AppColors.white,
                        textColor: AppColors.zucchini,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _matters(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._matter(
          context,
          '1',
          'Add More Animals',
          "We're constantly researching and \nadding new animal tracks",
        ),
        ..._matter(
          context,
          '2',
          'Improve the App',
          'Better graphics, smoother animations, and new features',
        ),
        ..._matter(
          context,
          '3',
          'Educational Content',
          'Create more educational materials and tracking guides',
        ),
      ],
    );
  }

  List<Widget> _matter(
    BuildContext context,
    String index,
    String title,
    String subtitle,
  ) {
    return [
      Row(
        children: [
          Container(
            width: 32.w,
            height: 32.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: AppColors.primary,
            ),
            child: Text(
              index,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(height: 1.3),
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            title,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              height: 1.5,
            ),
          ),
        ],
      ),
      Padding(
        padding: EdgeInsets.only(top: 8.h, bottom: 32.h),
        child: Text(subtitle, style: Theme.of(context).textTheme.displaySmall),
      ),
    ];
  }
}
