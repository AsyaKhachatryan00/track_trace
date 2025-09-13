import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:track_trace/core/config/constants/app_assets.dart';
import 'package:track_trace/core/config/theme/app_colors.dart';
import 'package:track_trace/core/route/routes.dart';
import 'package:track_trace/features/main/controller/main_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late MainController _controller;
  RxBool get _isNotsOn => _controller.isNotsOn;
  RxBool get _isPremium => _controller.isPremium;

  @override
  void initState() {
    super.initState();
    if (Get.isRegistered<MainController>()) {
      _controller = Get.find<MainController>();
    } else {
      _controller = Get.put(MainController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 50.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 24.w),
          child: InkWell(
            onTap: () => Get.back(id: 1),
            child: SvgPicture.asset(
              AppSvgs.left,
              width: 30.w,
              height: 30.h,
              fit: BoxFit.none,
            ),
          ),
        ),
        centerTitle: false,
        title: Text(
          'Settings',
          style: Theme.of(
            context,
          ).textTheme.displayLarge?.copyWith(fontWeight: FontWeight.w400),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            children: [
              Obx(() => _premiumDecoration()),

              SizedBox(height: 16.h),
              _decoration(
                Obx(
                  () => ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'Notifications',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontSize: 16.sp,
                        height: 24 / 16,
                        color: AppColors.white,
                      ),
                    ),
                    trailing: CupertinoSwitch(
                      value: _isNotsOn.value,
                      onChanged: (value) => _controller.setNots(value),
                    ),
                  ),
                ),
              ),

              _decoration(
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Terms of Use',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontSize: 16.sp,
                      height: 24 / 16,
                      color: AppColors.white,
                    ),
                  ),
                  trailing: Icon(Icons.chevron_right, color: AppColors.white),
                ),
              ),
              _decoration(
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Privacy Policy',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontSize: 16.sp,
                      height: 24 / 16,
                      color: AppColors.white,
                    ),
                  ),
                  trailing: Icon(Icons.chevron_right, color: AppColors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _premiumDecoration() => InkWell(
    onTap: () => _isPremium.value ? null : Get.toNamed(RouteLink.premium),

    child: Container(
      height: 160.h,
      width: 327.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color(0xFF35231A),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Stack(
        children: [
          Image.asset(
            AppImages.settings,
            fit: BoxFit.cover,
            height: 160.h,
            width: 327.w,
          ),
          Padding(
            padding: EdgeInsets.only(top: 62.h, bottom: 50.h),
            child: Center(
              child: Text(
                _isPremium.value ? 'Thanks for Support!' : 'Support our app!',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  height: 24 / 16,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: -10.96.h,
            left: 0.42.w,
            child: Image.asset(AppSvgs.settings_1, width: 88.w, height: 88.h),
          ),
          Positioned(
            top: 10.96.h,
            left: 151.52.w,
            child: Image.asset(AppSvgs.settings_2, width: 64.w, height: 64.h),
          ),
          Positioned(
            top: 0,
            right: 1.w,
            child: Image.asset(AppSvgs.settings_3, width: 64.w, height: 64.h),
          ),
          Positioned(
            bottom: 8,
            left: 108.w,
            child: Image.asset(AppSvgs.settings_4, width: 42.w, height: 42.h),
          ),
          Positioned(
            bottom: 0,
            right: 1.w,
            child: Image.asset(AppSvgs.settings_5, width: 64.w, height: 64.h),
          ),
        ],
      ),
    ),
  );

  Widget _decoration(Widget child) => Container(
    height: 64.h,
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(horizontal: 24.w),
    margin: EdgeInsets.only(bottom: 8.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.r),
      color: AppColors.zucchini,
    ),
    child: child,
  );
}
