import 'package:discoverrd/app/controllers/auth/register_controller.dart';
import 'package:discoverrd/app/services/base/api_service.dart';
import 'package:discoverrd/app/services/auth/token_service.dart';
import 'package:discoverrd/app/services/auth/user_service.dart';
import 'package:get/get.dart';

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TokenService());
    Get.lazyPut(() => ApiService());
    Get.lazyPut(() => UserService());
    Get.lazyPut(() => RegisterController());
  }
}
