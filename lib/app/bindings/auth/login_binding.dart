import 'package:discoverrd/app/controllers/auth/login_controller.dart';
import 'package:discoverrd/app/services/base/api_service.dart';
import 'package:discoverrd/app/services/auth/auth_service.dart';
import 'package:discoverrd/app/services/auth/token_service.dart';
import 'package:get/get.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TokenService());
    Get.lazyPut(() => ApiService());
    Get.lazyPut(() => AuthService());
    Get.lazyPut(() => LoginController());
  }
}
