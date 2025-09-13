import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trace/core/config/theme/app_colors.dart';
import 'package:track_trace/features/home/widgets/animal_item_content.dart';
import 'package:track_trace/models/animal.dart';
import 'package:track_trace/features/main/controller/main_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final MainController _controller;
  RxList<Animal> get _animals => _controller.animals;

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
        leading: SizedBox(),
        leadingWidth: 0,
        centerTitle: false,
        titleSpacing: 0,
        toolbarHeight: 36.h,
        title: Padding(
          padding: EdgeInsets.only(left: 24.w, top: 24.h),
          child: Text(
            'Track Guide',
            style: Theme.of(
              context,
            ).textTheme.displayLarge?.copyWith(fontWeight: FontWeight.w400),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _animals.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () => Get.dialog(
                AnimalItemContent(animal: _animals[index]),
                barrierDismissible: false,
              ),
              child: Container(
                width: 327.w,
                padding: EdgeInsets.all(8.w),
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: AppColors.zucchini,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Obx(
                        () => Icon(
                          _animals[index].isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: AppColors.alizarin,
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              _animals[index].image,
                              width: 44.w,
                              height: 44.h,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              _animals[index].name.toUpperCase(),
                              style: Theme.of(context).textTheme.displayLarge
                                  ?.copyWith(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
