import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trace/core/config/constants/app_assets.dart';
import 'package:track_trace/core/config/constants/storage_keys.dart';
import 'package:track_trace/core/config/theme/app_colors.dart';
import 'package:track_trace/core/route/routes.dart';
import 'package:track_trace/core/widgets/custom_button.dart';
import 'package:track_trace/core/widgets/dialog_screen.dart';
import 'package:track_trace/core/widgets/utils/shared_prefs.dart';
import 'package:track_trace/service_locator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  RxBool startAnimations = false.obs;
  late AnimationController _opacityController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _opacityController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_opacityController)..addListener(updateUi);

    Future.delayed(const Duration(milliseconds: 500), () {
      startAnimations.value = true;
      _opacityController.forward();
    });

    _opacityController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(microseconds: 3000), () async {
          final isNotificationsOn = locator<SharedPrefs>().getBool(
            StorageKeys.isNotificationsOn,
          );
          if (!isNotificationsOn) {
            openNotDialog();
          }
        });
      }
    });
  }

  void updateUi() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _opacityAnimation.removeListener(updateUi);
    _opacityController.dispose();
  }

  void openNotDialog() {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => DialogScreen(
        onTap: (value) => locator<SharedPrefs>().setBool(
          StorageKeys.isNotificationsOn,
          value,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedOpacity(
            opacity: 1 - _opacityAnimation.value,
            duration: Duration(milliseconds: 500),
            child: Center(
              child: Image.asset(AppImages.splash, width: 68.w, height: 68.h),
            ),
          ),

          AnimatedOpacity(
            opacity: _opacityController.value,
            duration: Duration(milliseconds: 1000),
            child: Container(
              color: AppColors.primary,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    bottom: 78.h,
                    right: -16.5.w,
                    child: Center(
                      child: Image.asset(
                        AppImages.splash1,
                        width: 337.w,
                        height: 347.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 24.w,
                    right: 73.w,
                    top: 98.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TrackTrace: \nAnimal Footprint',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        SizedBox(height: 24.h),
                        Text(
                          'Discover, learn, and master the art of tracking animal footprints. \nFrom wild to exotic — explore nature like never before!',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        SizedBox(height: 24.h),

                        CustomButton(
                          width: 278.w,
                          data: 'Lets Go!',
                          onTap: () => Get.offAllNamed(RouteLink.main),
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    left: 24.w,
                    top: 649.h,
                    right: 24.w,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Terms of Use ',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            Container(
                              width: 24.w,
                              alignment: Alignment.center,
                              height: 24.h,
                              margin: EdgeInsets.only(left: 9.w),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.zucchini,
                              ),
                              child: Icon(
                                Icons.keyboard_arrow_right_outlined,
                                color: AppColors.white,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        Row(
                          children: [
                            Text(
                              'Privacy Policy',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            Container(
                              width: 24.w,
                              height: 24.h,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(left: 8.w),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.zucchini,
                              ),
                              child: Icon(
                                Icons.keyboard_arrow_right_outlined,
                                size: 18,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
