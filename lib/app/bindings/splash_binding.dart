import 'package:discoverrd/app/controllers/splash_controller.dart';
import 'package:discoverrd/app/services/auth/token_service.dart';
import 'package:get/get.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TokenService());
    Get.lazyPut(() => SplashController());
  }
}
