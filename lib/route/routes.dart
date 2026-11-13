import 'package:get/get.dart';
import 'package:gutsynced/app/controller/app_binding.dart';
import 'package:gutsynced/route/route_method.dart';
import 'package:gutsynced/view/app_layout/app_layout.dart';
import 'package:gutsynced/view/apps/splash/splash_screen.dart';
import 'package:gutsynced/view/apps/auth/auth_screen.dart';
import 'package:gutsynced/view/apps/detail/detail_screen.dart';

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
