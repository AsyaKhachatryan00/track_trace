import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// Test helper functions for common test setup
class TestHelpers {
  /// Creates a test app with ScreenUtil initialized
  static Widget createTestApp({required Widget child}) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MaterialApp(home: child),
    );
  }

  /// Sets up GetX for testing
  static void setupGetX() {
    Get.testMode = true;
  }

  /// Cleans up GetX after testing
  static void cleanupGetX() {
    Get.reset();
  }

  /// Waits for all animations and timers to complete
  static Future<void> pumpAndSettleAll(WidgetTester tester) async {
    await tester.pumpAndSettle(const Duration(seconds: 5));
  }

  /// Pumps widget and waits for a specific duration
  static Future<void> pumpAndWait(
    WidgetTester tester,
    Duration duration,
  ) async {
    await tester.pump();
    await tester.pump(duration);
  }
}
