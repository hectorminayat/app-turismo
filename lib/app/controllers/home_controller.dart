import 'package:discoverrd/app/models/agency_view.dart';
import 'package:discoverrd/app/models/customer_view.dart';
import 'package:discoverrd/app/models/tour_reserve_view.dart';
import 'package:discoverrd/app/models/tour_view.dart';
import 'package:discoverrd/app/routes/app_pages.dart';
import 'package:discoverrd/app/services/auth/auth_service.dart';
import 'package:discoverrd/app/services/auth/token_service.dart';
import 'package:discoverrd/app/services/auth/user_service.dart';
import 'package:discoverrd/app/services/tour_service.dart';
import 'package:discoverrd/app/widgets/custom_alert_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class HomeController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final TokenService _tokenService = Get.find<TokenService>();
  final RxMap<String, dynamic> userInfo = Map<String, dynamic>().obs;
  final UserService _service = Get.find<UserService>();
  final TourService _tourService = Get.find<TourService>();
  final RxList<TourView> popularTours = RxList<TourView>();
  final RxList<TourView> likesTours = RxList<TourView>();
  final RxList<TourReserveView> reservesTours = RxList<TourReserveView>();
  final RxList<AgencyView> popularAgency = RxList<AgencyView>();

  final RxInt currentPage = 0.obs;
  final RxInt previousPage = 0.obs;
  final RxBool isAgency = false.obs;

  RxString imageProfile = "".obs;
  RxString name = "".obs;
  RxString email = "".obs;
  final RxBool loading = true.obs;

  @override
  void onInit() async {
    super.onInit();
    await Jiffy.locale("es");
    await _load();
  }

  _load() async {
    try {
      loading.value = true;
      Get.dialog(Center(child: CircularProgressIndicator()),
          barrierDismissible: false);
      await _getUserInfo();
      await _getPopularTourList();
      await _getPopularAgencyList();
      await _getLikesTourList();
      await _getReserveTourList();
      Get.back();
      loading.value = false;
    } catch (e) {
      print("*****************************************************");
      print(e);
      Get.back();
      Get.dialog(CustomAlertDialog(
        title: 'Ha ocurrido un error',
        content: 'Tenemos problemas para procesar su solicitud.',
        okText: 'Aceptar',
      ));
      loading.value = false;
    }
  }

  _getUserInfo() async {
    userInfo.addAll((_tokenService.getUserInfo() as Map<String, dynamic>));
    isAgency.value = (userInfo['UserType'].toString() == '2');

    try {
      if (isAgency.value == true) {
        AgencyView data = await _service.getAgencyByid();
        name.value = data.name ?? "";
        email.value = data.email ?? "";
        imageProfile.value = data.image!;
      } else {
        CustomerView data = await _service.getCustomerByid();
        name.value = data.name! + " " + data.lastName!;
        email.value = data.email!;
        imageProfile.value = data.image!;
      }
    } catch (e) {}
  }

  logout() {
    _authService.logout();
    Get.offNamed(Routes.LOGIN);
  }

  void toDetail(TourView tour) {
    Get.toNamed('${Routes.TOUR_DETAIL}?id=${tour.tour!.id}');
  }

  void toViewReserve(TourReserveView tour) {
    Get.toNamed('${Routes.TOUR_RESERVE_DETAIL}?id=${tour.id}');
  }

  setCurrentPage(int index) async {
    previousPage.value = currentPage.value;
    currentPage.value = index;
    if (isAgency.value && index == 1) {
      currentPage.value = previousPage.value;
      Get.offNamed(Routes.REGISTER_TOUR);
    }
    if (!isAgency.value && index == 1) {
      await _getLikesTourList();
    }
  }

  goToEditProfile(String type) async {
    Get.toNamed('${Routes.EDIT_USER}?id=$type')!
        .then((value) => _getUserInfo());
  }

  goToSearch() async {
    Get.toNamed(Routes.SEARCH);
  }

  _getPopularTourList() async {
    var result = await _tourService.popular();
    popularTours.value = List.from(result);
  }

  _getLikesTourList() async {
    var result = await _tourService.likes();
    likesTours.value = List.from(result);
  }

  _getPopularAgencyList() async {
    var result = await _service.getPopularAgency();
    popularAgency.value = List.from(result);
  }

  _getReserveTourList() async {
    var result = await _tourService.reserves();
    reservesTours.value = List.from(result);
  }
}
