import 'package:discoverrd/app/controllers/tour_controller.dart';
import 'package:discoverrd/app/services/tour_service.dart';
import 'package:discoverrd/app/services/base/api_service.dart';
import 'package:discoverrd/app/services/auth/token_service.dart';
import 'package:get/get.dart';

class RegisterTourBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TokenService());
    Get.lazyPut(() => ApiService());
    Get.lazyPut(() => TourService());
    Get.lazyPut(() => TourController());
  }
}
