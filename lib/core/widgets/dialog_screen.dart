import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trace/core/config/theme/app_colors.dart';

class DialogScreen extends StatelessWidget {
  const DialogScreen({required this.onTap, super.key, this.title});
  final String? title;
  final ValueChanged<bool> onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
        child: CupertinoAlertDialog(
          title: Text(
            title ??
                '“TrackTrace: Animal Footprint” Would Like to Send You Push Notifications',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),

          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              isDefaultAction: false,
              onPressed: () {
                onTap.call(title != null);
                Get.back();
              },
              child: Text(
                title != null ? 'Yes' : 'Don’t Allow',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: title == null ? AppColors.blue : AppColors.red,

                  fontWeight: title == null ? FontWeight.w400 : FontWeight.w500,
                ),
              ),
            ),

            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                onTap.call(title == null);
                Get.back();
              },
              child: Text(
                title != null ? 'No' : 'OK',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: AppColors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
