import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:track_trace/core/config/constants/app_assets.dart';
import 'package:track_trace/core/config/theme/app_colors.dart';
import 'package:track_trace/core/route/routes.dart';
import 'package:track_trace/core/widgets/dialog_screen.dart';
import 'package:track_trace/features/main/controller/main_controller.dart';
import 'package:track_trace/features/quiz/controller/quiz_controller.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.isRegistered()
        ? Get.find<MainController>()
        : Get.put(MainController());

    final RxInt index = controller.screenIndex;

    return Obx(
      () => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
          border: Border(
            top: BorderSide(color: AppColors.white.withValues(alpha: 0.08)),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColors.mainBg,
          currentIndex: index.value,
          onTap: (value) async {
            if (controller.currentNestedRoute.value == RouteLink.play) {
              bool? shouldLeave = false;
              await Get.dialog(
                DialogScreen(
                  title: 'Are you sure you want to leave this quest?',
                  onTap: (v) {
                    if (v) {
                      Get.back(id: 1);
                      shouldLeave = v;
                    }
                  },
                ),
                barrierDismissible: false,
              );

              if (shouldLeave == true) {
                if (Get.isRegistered<QuizController>()) {
                  Get.find<QuizController>().dispose();
                  Get.delete<QuizController>();
                }
                index.value = value;

                switch (value) {
                  case 0:
                    Get.toNamed(RouteLink.home, id: 1);
                    break;
                  case 1:
                    Get.toNamed(RouteLink.quiz, id: 1);
                    break;
                  case 2:
                    Get.toNamed(RouteLink.settings, id: 1);
                    break;
                }
              }

              return;
            }

            index.value = value;

            switch (value) {
              case 0:
                Get.toNamed(RouteLink.home, id: 1);
                break;
              case 1:
                Get.toNamed(RouteLink.quiz, id: 1);
                break;
              case 2:
                Get.toNamed(RouteLink.settings, id: 1);
                break;
            }
          },

          items: [
            BottomNavigationBarItem(
              icon: Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: index.value == 0
                      ? AppColors.white.withValues(alpha: 0.13)
                      : null,
                ),
                child: SvgPicture.asset(
                  AppSvgs.main,
                  width: 24.w,
                  height: 24.h,
                  fit: BoxFit.none,
                  colorFilter: ColorFilter.mode(
                    index.value == 0
                        ? AppColors.white
                        : AppColors.lightCyan.withValues(alpha: 0.47),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: index.value == 1
                      ? AppColors.white.withValues(alpha: 0.13)
                      : null,
                ),
                child: SvgPicture.asset(
                  AppSvgs.quiz,
                  width: 24.w,
                  height: 24.h,
                  fit: BoxFit.none,
                  colorFilter: ColorFilter.mode(
                    index.value == 1
                        ? AppColors.white
                        : AppColors.lightCyan.withValues(alpha: 0.47),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: index.value == 2
                      ? AppColors.white.withValues(alpha: 0.13)
                      : null,
                ),
                child: SvgPicture.asset(
                  AppSvgs.setting,
                  width: 24.w,
                  height: 24.h,
                  fit: BoxFit.none,
                  colorFilter: ColorFilter.mode(
                    index.value == 2
                        ? AppColors.white
                        : AppColors.lightCyan.withValues(alpha: 0.47),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
