import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trace/core/config/theme/app_colors.dart';
import 'package:track_trace/core/widgets/custom_button.dart';
import 'package:track_trace/features/main/controller/main_controller.dart';
import 'package:track_trace/models/animal.dart';

class AnimalItemContent extends StatelessWidget {
  const AnimalItemContent({super.key, required this.animal});
  final Animal animal;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.black,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 30.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  animal.name.toUpperCase(),
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                InkWell(
                  onTap: () => Get.back(),
                  child: Icon(Icons.close, color: AppColors.white),
                ),
              ],
            ),
            SizedBox(height: 37.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 5.h,
                      ),
                      margin: EdgeInsets.only(bottom: 8.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: AppColors.mainBg,
                      ),
                      child: Text(
                        animal.category.name.capitalizeFirst!,
                        style: Theme.of(context).textTheme.displaySmall
                            ?.copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                            ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 5.h,
                      ),
                      margin: EdgeInsets.only(bottom: 8.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: AppColors.mainBg,
                      ),
                      child: Text(
                        animal.footType.name.capitalizeFirst!,
                        style: Theme.of(context).textTheme.displaySmall
                            ?.copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                            ),
                      ),
                    ),
                  ],
                ),
                Image.asset(animal.image, width: 56.w, height: 60.h),
              ],
            ),
            SizedBox(height: 59.h),
            GetBuilder<MainController>(
              builder: (controller) => CustomButton(
                color: AppColors.white,
                onTap: () => controller.updateFav(animal),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      animal.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: AppColors.alizarin,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      animal.isFavorite
                          ? 'Remove from Favourites'
                          : 'Add to Favorites',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
