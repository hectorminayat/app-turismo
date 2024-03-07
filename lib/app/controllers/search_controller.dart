import 'package:discoverrd/app/models/dtos/tour_search_dto.dart';
import 'package:discoverrd/app/models/tour_dates_rage.dart';
import 'package:discoverrd/app/models/tour_view.dart';
import 'package:discoverrd/app/pages/home/pages/search/search_age.dart';
import 'package:discoverrd/app/pages/home/pages/search/search_dates.dart';
import 'package:discoverrd/app/pages/home/pages/search/search_price.dart';
import 'package:discoverrd/app/pages/utils/search_place_page.dart';
import 'package:discoverrd/app/routes/app_pages.dart';
import 'package:discoverrd/app/services/tour_service.dart';
import 'package:discoverrd/app/widgets/custom_alert_dialog.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SearchController extends GetxController {
  final TourService _service = Get.find<TourService>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  RxString location = ''.obs;
  Rx<TourDatesRage> tourDatesRangeCache = TourDatesRage().obs;
  Rx<TourDatesRage> tourDatesRange = TourDatesRage().obs;
  DateRangePickerController dateRangeCtrl = DateRangePickerController();
  TextEditingController minAgePRCtrl = TextEditingController(text: '18');

  MoneyMaskedTextController minPricePRCtrl = MoneyMaskedTextController(
      leftSymbol: 'RD\$ ', decimalSeparator: '.', thousandSeparator: ',');

  MoneyMaskedTextController maxPricePRCtrl = MoneyMaskedTextController(
      leftSymbol: 'RD\$ ', decimalSeparator: '.', thousandSeparator: ',');

  RxInt age = 0.obs;
  RxDouble minPrice = 0.0.obs;
  RxDouble maxPrice = 0.0.obs;
  RxBool loading = false.obs;

  final RxList<TourView> tours = RxList<TourView>();

  @override
  void onReady() async {
    super.onReady();
    openDrawer();
  }

  void openDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  //Location
  setLocation() async {
    AutocompletePrediction? result = await Get.to(() => SearchPlacePage(
          pageTitle: 'Ubicación',
          types: '(cities)',
          initialValue: location.value,
        ));
    if (result != null) location.value = result.description!;
  }

  setDates() {
    Get.to(() => SearchDates());
  }

  setAge() {
    Get.to(() => SearchAge());
  }

  setPrice() {
    Get.to(() => SearchPrice());
  }

  void clearDates() {
    // tourDatesRangeCache.value = tourDatesRange.value;
    // dateRangeCtrl.selectedRange = null;
    Get.back();
  }

  void saveDates() {
    if (dateRangeCtrl.selectedRange != null) {
      final range = dateRangeCtrl.selectedRange;
      tourDatesRange.value =
          TourDatesRage(startDate: range!.startDate, endDate: range.endDate);
    }
    Get.back();
  }

  saveAge() {
    age.value = int.parse(minAgePRCtrl.text);
    Get.back();
  }

  savePrice() {
    minPrice.value = minPricePRCtrl.numberValue;
    maxPrice.value = maxPricePRCtrl.numberValue;
    Get.back();
  }

  void clear() {
    age.value = 0;
    minPrice.value = 0;
    maxPrice.value = 0;
    location.value = '';
    tourDatesRange.value = TourDatesRage();
    tourDatesRangeCache.value = TourDatesRage();
  }

  void toDetail(TourView tour) {
    Get.toNamed('${Routes.TOUR_DETAIL}?id=${tour.tour!.id}');
  }
  
  void submit() async {
    loading.value = true;
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    try {
      TourSeachDto data = TourSeachDto(
          location: location.value,
          minAge: age.value,
          tourDateRage: tourDatesRange.value,
          minPrice: minPrice.value,
          maxPrice: maxPrice.value);

      final result = await _service.search(data);
      tours.value = List.from(result);
      loading.value = false;
      Get.back();
      Get.back();
    } catch (e) {
      loading.value = false;
      Get.back();
      Get.dialog(CustomAlertDialog(
        title: 'Ha ocurrido un error',
        content: 'Tenemos problemas para procesar su solicitud.',
        okText: 'Aceptar',
      ));
    }
  }
}
