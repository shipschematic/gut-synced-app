import 'package:get/get.dart';
import 'package:gut_sync/app/controller/food_controller.dart';
import 'package:gut_sync/app/controller/auth_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FoodController>(FoodController(), permanent: true);
    Get.put<AuthController>(AuthController(), permanent: true);
  }
}
