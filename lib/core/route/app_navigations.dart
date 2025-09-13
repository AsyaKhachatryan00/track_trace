import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trace/core/route/routes.dart';
import 'package:track_trace/core/widgets/utils/shared_prefs.dart';
import 'package:track_trace/features/home/home_screen.dart';
import 'package:track_trace/features/main/main_screen.dart';
import 'package:track_trace/features/premium/premium_screen.dart';
import 'package:track_trace/features/quiz/quiz_screen.dart';
import 'package:track_trace/features/quiz/widgets/play_screen.dart';
import 'package:track_trace/features/settings/settings_screen.dart';
import 'package:track_trace/features/splash/splash_screen.dart';
import 'package:track_trace/service_locator.dart';

class AppRoute {
  factory AppRoute() => AppRoute._internal();

  AppRoute._internal();
  final main = Get.nestedKey(0);
  final nested = Get.nestedKey(1);

  Bindings? initialBinding() {
    return BindingsBuilder(() {
      locator<SharedPrefs>();
    });
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteLink.splash:
        return pageRouteBuilder(page: SplashScreen());

      case RouteLink.main:
        return pageRouteBuilder(page: MainScreen());

      case RouteLink.premium:
        return pageRouteBuilder(page: PremiumScreen());

      default:
        return pageRouteBuilder(
          page: Scaffold(body: Container(color: Colors.red)),
        );
    }
  }

  GetPageRoute pageRouteBuilder({
    required Widget page,
    RouteSettings? settings,
  }) => GetPageRoute(
    transitionDuration: Duration.zero,
    page: () => page,
    settings: settings,
  );
  Route? generateNestedRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteLink.home:
        return pageRouteBuilder(
          page: HomeScreen(),
          settings: RouteSettings(name: RouteLink.home),
        );

      case RouteLink.quiz:
        return pageRouteBuilder(
          page: QuizScreen(),
          settings: RouteSettings(name: RouteLink.quiz),
        );

      case RouteLink.play:
        {
          final PlayModes mode = settings.arguments as PlayModes;
          return pageRouteBuilder(
            page: PlayScreen(mode: mode),
            settings: RouteSettings(name: RouteLink.play),
          );
        }

      case RouteLink.settings:
        return pageRouteBuilder(
          page: SettingsScreen(),
          settings: RouteSettings(name: RouteLink.settings),
        );
    }

    return null;
  }
}
