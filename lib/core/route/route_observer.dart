import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trace/core/route/routes.dart';
import 'package:track_trace/features/main/controller/main_controller.dart';

class NavRouteObserver extends GetObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    final MainController controller = Get.find<MainController>();
    final routeName = previousRoute?.settings.name ?? '';
    controller.currentNestedRoute.value = routeName;

    if (routeName == RouteLink.home) {
      controller.screenIndex.value = 0;
    } else if (routeName == RouteLink.quiz) {
      controller.screenIndex.value = 1;
    } else if (routeName == RouteLink.settings) {
      controller.screenIndex.value = 2;
    }
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    final MainController controller = Get.find<MainController>();
    final routeName = route.settings.name ?? '';
    controller.currentNestedRoute.value = routeName;
    super.didPush(route, previousRoute);
  }
}
