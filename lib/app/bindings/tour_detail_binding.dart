import 'package:discoverrd/app/controllers/tour_detail_controller.dart';
import 'package:discoverrd/app/services/tour_service.dart';
import 'package:discoverrd/app/services/base/api_service.dart';
import 'package:discoverrd/app/services/auth/token_service.dart';
import 'package:get/get.dart';

class TourDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TokenService());
    Get.lazyPut(() => ApiService());
    Get.lazyPut(() => TourService());
    Get.lazyPut(() => TourDetailController());
  }
}
