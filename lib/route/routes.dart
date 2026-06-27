import 'package:get/get.dart';
import 'package:gut_sync/app/controller/app_binding.dart';
import 'package:gut_sync/route/route_method.dart';
import 'package:gut_sync/view/app_layout/app_layout.dart';
import 'package:gut_sync/view/apps/splash/splash_screen.dart';
import 'package:gut_sync/view/apps/auth/auth_screen.dart';
import 'package:gut_sync/view/apps/detail/detail_screen.dart';

List<GetPage> getPageRoute() => [
      GetPage(
        name: route.splash,
        page: () => const SplashScreen(),
        binding: AppBinding(),
        transition: Transition.noTransition,
      ),
      GetPage(
        name: route.auth,
        page: () => const AuthScreen(),
        transition: Transition.noTransition,
      ),
      GetPage(
        name: route.appLayout,
        page: () => const AppLayout(),
        binding: AppBinding(),
        transition: Transition.noTransition,
      ),
      GetPage(
        name: route.foodDetail,
        page: () => DetailScreen(foodName: Get.parameters['name'] ?? ''),
        transition: Transition.noTransition,
      ),
    ];
