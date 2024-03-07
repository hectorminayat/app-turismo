import 'package:discoverrd/app/controllers/agency_tour_list_controller.dart';
import 'package:discoverrd/app/services/auth/token_service.dart';
import 'package:discoverrd/app/services/base/api_service.dart';
import 'package:discoverrd/app/services/tour_service.dart';
import 'package:get/get.dart';

class AgencyTourListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TokenService());
    Get.lazyPut(() => ApiService());
    Get.lazyPut(() => TourService());
    Get.lazyPut(() => AgencyTourListController());
  }
}
