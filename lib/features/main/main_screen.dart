import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trace/core/route/app_navigations.dart';
import 'package:track_trace/core/route/route_observer.dart';
import 'package:track_trace/core/route/routes.dart';
import 'package:track_trace/features/main/controller/main_controller.dart';
import 'package:track_trace/features/main/widgets/bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final MainController _controller;

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
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      body: Navigator(
        observers: [NavRouteObserver()],
        key: AppRoute().nested,
        initialRoute: RouteLink.home,
        onGenerateRoute: (RouteSettings settings) =>
            AppRoute().generateNestedRoute(settings),
      ),
    );
  }
}
