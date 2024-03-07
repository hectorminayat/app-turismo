import 'package:discoverrd/app/config/app_config.dart';
import 'package:discoverrd/app/models/image_ps.dart';
import 'package:discoverrd/app/models/dtos/tour_dto.dart';
import 'package:discoverrd/app/models/tour.dart';
import 'package:discoverrd/app/models/tour_dates.dart';
import 'package:discoverrd/app/models/tour_dates_rage.dart';
import 'package:discoverrd/app/models/tour_meeting_place.dart';
import 'package:discoverrd/app/models/include_item.dart';
import 'package:discoverrd/app/models/tour_participants_requirements.dart';
import 'package:discoverrd/app/models/tour_price.dart';
import 'package:discoverrd/app/models/tour_view.dart';
import 'package:discoverrd/app/pages/form_tour/register_tour_dates.dart';
import 'package:discoverrd/app/pages/form_tour/register_tour_duration.dart';
import 'package:discoverrd/app/pages/form_tour/register_tour_meeting_place.dart';
import 'package:discoverrd/app/pages/form_tour/register_tour_include.dart';
import 'package:discoverrd/app/pages/form_tour/register_tour_participants_requirements.dart';
import 'package:discoverrd/app/pages/form_tour/register_tour_price.dart';
import 'package:discoverrd/app/pages/utils/search_place_page.dart';
import 'package:discoverrd/app/routes/app_pages.dart';
import 'package:discoverrd/app/services/tour_service.dart';
import 'package:discoverrd/app/widgets/custom_alert_dialog.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';
import 'package:jiffy/jiffy.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:dio/dio.dart' as dio;

class TourController extends GetxController {
  final TourService _service = Get.find<TourService>();

  RxList<ImagePS> images = RxList<ImagePS>();
  List<ImagePS>? initialImages;
  RxString pageTile = "Nueva excursión".obs;
  RxInt imagesLength = 0.obs;
  RxString location = ''.obs;

  Rx<Tour> tour = Tour().obs;
  Rx<TourMeetingPlace> tourMeetingPlace = TourMeetingPlace().obs;
  Rx<TourMeetingPlace> tourMeetingPlaceCache = TourMeetingPlace().obs;
  Rx<TourParticipantsRequirements> tourParticipantsRequirements =
      TourParticipantsRequirements().obs;
  Rx<TourPrice> tourPrice =
      TourPrice(adultPrice: 0, kidPrice: 0, enableKidPrice: false).obs;

  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
  TextEditingController minAgePRCtrl = TextEditingController(text: '18');
  TextEditingController kidAgePRCtrl = TextEditingController(text: '12');
  TextEditingController optionalPRCtrl = TextEditingController();

  TextEditingController descpTMPCtrl = TextEditingController();

  MoneyMaskedTextController adultPriceCtrl = MoneyMaskedTextController(
      leftSymbol: 'RD\$ ', decimalSeparator: '.', thousandSeparator: ',');
  MoneyMaskedTextController kidPriceCtrl = MoneyMaskedTextController(
      leftSymbol: 'RD\$ ', decimalSeparator: '.', thousandSeparator: ',');

  RxBool showKidAge = false.obs;

  RxList<int> includes = RxList<int>();
  RxList<int> includesCache = RxList<int>();

  RxInt durationTypeToggle = 0.obs;
  RxInt durationValue = 0.obs;

  DateRangePickerController dateRangeCtrl = DateRangePickerController();

  RxList<TourDates> tourDates = RxList<TourDates>();
  RxList<TourDates> tourDatesCache = RxList<TourDates>();
  RxList<TourDatesRage> tourDatesRange = RxList<TourDatesRage>();
  RxList<TourDatesRage> tourDatesRangeCache = RxList<TourDatesRage>();

  List<IncludeItem> includeItems = [
    IncludeItem(id: 1, name: 'Refrigerios', includeCategoryId: 1),
    IncludeItem(id: 2, name: 'Almuerzo', includeCategoryId: 1),
    IncludeItem(id: 3, name: 'Desayuno', includeCategoryId: 1),
    IncludeItem(id: 4, name: 'Cena', includeCategoryId: 1),
    IncludeItem(id: 5, name: 'Postre', includeCategoryId: 1),
    IncludeItem(id: 6, name: 'Merienda', includeCategoryId: 1),
    IncludeItem(id: 7, name: 'Aperitivos', includeCategoryId: 1),
    IncludeItem(id: 8, name: 'Cerviza', includeCategoryId: 2),
    IncludeItem(id: 9, name: 'Agua', includeCategoryId: 2),
    IncludeItem(id: 10, name: 'Jugo', includeCategoryId: 2),
    IncludeItem(id: 11, name: 'Refrescos', includeCategoryId: 2),
    IncludeItem(id: 12, name: 'Equipo deportivo', includeCategoryId: 3),
    IncludeItem(id: 13, name: 'Equipo para exteriores', includeCategoryId: 3),
    IncludeItem(id: 14, name: 'Equipo de seguridad', includeCategoryId: 3),
    IncludeItem(id: 15, name: 'Materiales', includeCategoryId: 3),
    IncludeItem(id: 16, name: 'Cámara', includeCategoryId: 3),
    IncludeItem(id: 17, name: 'Fotografía', includeCategoryId: 3),
    IncludeItem(id: 18, name: 'Entrada de parques', includeCategoryId: 4),
    IncludeItem(id: 19, name: 'Entrada para eventos', includeCategoryId: 4),
    IncludeItem(id: 20, name: 'Tarifa de entrada', includeCategoryId: 4),
  ];

  Map<int, String> durtationHours = {};
  Map<int, String> durtationDays = {};

  RxMap<String, String> validations = {"title": ""}.obs;
  bool loading = false;

  RxBool loadingData = false.obs;

  bool editMode = false;
  String id = "0";

  List<DateTime>? initialSelectedDates;
  List<PickerDateRange>? initialSelectedRanges;

//ON
  @override
  void onInit() async {
    super.onInit();
    if (!(Get.parameters["id"]?.isEmpty ?? true)) {
      editMode = true;
      id = Get.parameters["id"]!;
      await _editTour();
    }
  }

  @override
  void onReady() async {
    super.onReady();
    await Jiffy.locale("es");
    _loadDurationsData();
  }

//EDIT
  Future<void> _editTour() async {
    loadingData.value = true;
    pageTile.value = "Editar excursión";

    try {
      TourView editTour = await _service.getByid(id);
      Tour tourResult = editTour.tour!;

      initialImages = editTour.images!
          .map((e) => ImagePS(path: '${AppConfig.API_URL}/file/$e', type: 1))
          .toList();
      titleCtrl.text = tourResult.title!;
      descriptionCtrl.text = tourResult.description!;
      location.value = tourResult.location!;

      tourMeetingPlace.value = tourResult.tourMeetingPlace!;
      tourParticipantsRequirements.value =
          tourResult.tourParticipantsRequirements!;
      includes.value = tourResult.includesList!;

      adultPriceCtrl.updateValue(tourResult.adultPrice);
      kidPriceCtrl.updateValue(tourResult.kidPrice);

      tourPrice.value = TourPrice(
          adultPrice: tourResult.adultPrice ?? 0.00,
          kidPrice: tourResult.kidPrice ?? 0.00,
          enableKidPrice: tourResult.enableKidPrice ?? false);

      tourDates.value = tourResult.tourDates!;
      tourDatesRange.value = tourResult.tourDatesRages!;

      tourDatesCache.value = List.from(tourDates);
      tourDatesRangeCache.value = List.from(tourDatesRange);

      if (tourResult.tourDates!.length > 0) {
        initialSelectedDates =
            tourResult.tourDates!.map((e) => e.date!).toList();
      }
      if (tourResult.tourDatesRages!.length > 0) {
        initialSelectedRanges = tourResult.tourDatesRages!
            .map((e) => PickerDateRange(e.startDate, e.endDate))
            .toList();
      }

      tour.value = tour.value.copyWith(
          title: tourResult.title,
          description: tourResult.description,
          location: tourResult.location,
          duration: tourResult.duration,
          durationType: tourResult.durationType,
          kidPrice: tourResult.kidPrice,
          adultPrice: tourResult.adultPrice,
          enableKidPrice: tourResult.enableKidPrice,
          tourStatusId: tourResult.tourStatusId);

      loadingData.value = false;
    } catch (e) {
      Get.back();
      Get.dialog(CustomAlertDialog(
        title: 'Ha ocurrido un error',
        content: 'Tenemos problemas para procesar su solicitud.',
        okText: 'Aceptar',
      ));
      loadingData.value = false;
    }
  }

  void _loadDurationsData() {
    var listH = new List<int>.generate(16, (i) => i + 1);
    var listD = new List<int>.generate(20, (i) => i + 1);

    durtationHours = Map<int, String>.fromIterable(listH,
        key: (e) => e, value: (e) => e.toString());
    durtationDays = Map<int, String>.fromIterable(listD,
        key: (e) => e, value: (e) => e.toString());
    print(durtationHours);
  }

  onChangeImages(List<ImagePS> files) {
    images.value = files;
    imagesLength.value = images.length;
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

//TOUR MEETING PLACE
  setMeetingPlace() {
    tourMeetingPlaceCache.value = tourMeetingPlace.value;
    descpTMPCtrl.text = tourMeetingPlace.value.description ?? '';
    Get.to(() => RegisterTourMeetingPlace());
  }

  setMeetingPlaceLocation() async {
    AutocompletePrediction? result = await Get.to(() => SearchPlacePage(
        pageTitle: 'Ubicación', initialValue: tourMeetingPlace.value.address));

    if (result != null)
      tourMeetingPlaceCache.value =
          tourMeetingPlaceCache.value.copyWith(address: result.description);
  }

  setMeetingHour(TimeOfDay? timeOfDay) {
    print(timeOfDay!.format(Get.context!));
    tourMeetingPlaceCache.value = tourMeetingPlaceCache.value
        .copyWith(hour: timeOfDay.format(Get.context!));
  }

  saveTourMeetingPlace() {
    tourMeetingPlace.value =
        tourMeetingPlaceCache.value.copyWith(description: descpTMPCtrl.text);
    Get.back();
  }

  clearTourMeetingPlace() {
    tourMeetingPlaceCache.value = tourMeetingPlace.value;
    descpTMPCtrl.text = tourMeetingPlace.value.description ?? '';
    Get.back();
  }

//PRICE
  setPrice() {
    adultPriceCtrl.updateValue(tourPrice.value.adultPrice);
    kidPriceCtrl.updateValue(tourPrice.value.kidPrice);
    Get.to(() => RegisterTourPrice());
  }

  void savePrice() {
    tourPrice.value = TourPrice(
        adultPrice: adultPriceCtrl.numberValue,
        kidPrice: kidPriceCtrl.numberValue,
        enableKidPrice: showKidAge.value);
    Get.back();
  }

//DURATION
  setDuration() {
    Get.to(() => RegisterTourDuration());
  }

  setDurationTypeToggle(int type) {
    durationTypeToggle.value = type;
  }

  void setDurationValue(int? value) {
    durationValue.value = value ?? 0;
  }

  void saveDuracion() {
    tour.value = tour.value.copyWith(
        duration: durationValue.value, durationType: durationTypeToggle.value);
    Get.back();
  }

  void clearDuration() {
    durationValue.value = tour.value.duration ?? 0;
    durationTypeToggle.value = tour.value.durationType ?? 0;
    Get.back();
  }

//DATES
  setDates() {
    Get.to(() => RegisterTourDates());
  }

  void clearDates() {
    tourDatesCache.clear();
    tourDatesCache.value = List.from(tourDates);

    tourDatesRangeCache.clear();
    tourDatesRangeCache.value = List.from(tourDatesRange);

    dateRangeCtrl.selectedRanges = null;
    dateRangeCtrl.selectedDates = null;
    Get.back();
  }

  void saveDates() {
    if (dateRangeCtrl.selectedDates != null) {
      tourDates.clear();
      dateRangeCtrl.selectedDates!.forEach((date) {
        tourDates.add(TourDates(date: date));
      });
    }
    if (dateRangeCtrl.selectedRanges != null) {
      tourDatesRange.clear();
      dateRangeCtrl.selectedRanges!.forEach((range) {
        tourDatesRange.add(
            TourDatesRage(startDate: range.startDate, endDate: range.endDate));
      });
    }
    Get.back();
  }

//Participants Requirements
  savePartReq() {
    tourParticipantsRequirements.value = tourParticipantsRequirements.value
        .copyWith(
            minAge: int.parse(minAgePRCtrl.text),
            kidAge: int.parse(kidAgePRCtrl.text),
            optional: optionalPRCtrl.text);
    Get.back();
  }

  minAngeOnchanged(String? value) {
    showKidAge.value = (int.parse(value!) < 18);
  }

  setParticipantsRequirements() {
    Get.to(() => RegisterTourParticipantsRequirements());
  }

//INCLUDES
  void clearInclude() {
    includesCache.clear();
    includesCache.value = List.from(includes);
    Get.back();
  }

  void saveIncludes() {
    includes.clear();
    includes.value = List.from(includesCache);
    Get.back();
  }

  setInclude() {
    includesCache.clear();
    includesCache.value = List.from(includes);
    Get.to(() => RegisterTourInclude());
  }

//###########################
  void setPublish(bool value) {
    if (value && !_checkPublish()) {
      tour.value = tour.value.copyWith(tourStatusId: 3);

      Get.dialog(CustomAlertDialog(
        title: 'Completar formulario',
        content:
            'Debes de completar el formulario para poder publicar la excursión.',
        okText: 'Aceptar',
      ));

      return;
    }
    tour.value = tour.value.copyWith(tourStatusId: value ? 1 : 2);
  }

  bool _validate() {
    bool isValid = true;
    validations.clear();
    if (titleCtrl.text == "") {
      validations['title'] = 'El titulo es requerido.';
      isValid = false;
    }
    if (descriptionCtrl.text == "") {
      validations['description'] = 'La descripcion es requerida.';
      isValid = false;
    }
    if (images.length == 0) {
      validations['images'] = 'Agregar por lo menos una foto.';
      isValid = false;
    }
    return isValid;
  }

  bool _checkPublish() {
    bool check = true;

    if (titleCtrl.text == "") {
      check = false;
    }
    if (descriptionCtrl.text == "") {
      check = false;
    }
    if (images.length == 0) {
      check = false;
    }
    if (location.value == '') {
      check = false;
    }
    if (tour.value.durationType == null && tour.value.duration == null) {
      check = false;
    }
    if (tourDates.length == 0 && tourDatesRange.length == 0) {
      check = false;
    }
    if (tourPrice.value.adultPrice == 0) {
      check = false;
    }
    if ((tourMeetingPlace.value.address ?? '') == '') {
      check = false;
    }
    if ((tourMeetingPlace.value.hour ?? '') == '') {
      check = false;
    }
    if (includes.length == 0) {
      check = false;
    }

    return check;
  }

  void submit() async {
    if (!_validate()) return;
    loading = true;
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    try {
      var imageFiles = await Future.wait(images
          .where((x) => x.type == 0)
          .map((e) async => await dio.MultipartFile.fromFile(e.path!,
              filename: e.path!.split('/').last))
          .toList());

      var imagesSource = images
          .where((x) => x.type == 1)
          .map((e) => e.path!.split('/').last)
          .toList();

      TourDto data = TourDto(
          id: int.parse(id),
          title: titleCtrl.text,
          description: descriptionCtrl.text,
          imageFiles: imageFiles,
          imagesSource: imagesSource,
          location: location.value,
          durationType: tour.value.durationType,
          duration: tour.value.duration,
          tourMeetingPlace: tourMeetingPlace.value,
          tourParticipantsRequirements: tourParticipantsRequirements.value,
          includes: includes,
          tourDates: tourDates,
          tourDatesRage: tourDatesRange,
          adultPrice: tourPrice.value.adultPrice,
          tourStatusId: tour.value.tourStatusId,
          kidPrice: tourPrice.value.kidPrice);

      if (editMode) {
        await _service.edit(data);
      } else {
        await _service.register(data);
      }
      loading = false;

      Get.back();
      Get.dialog(CustomAlertDialog(
        title: 'Exito!',
        content: 'La excursion se guardo correctamente.',
        okText: 'Aceptar',
        onPressedOk: () {
          Get.back();
          Get.offAllNamed(Routes.HOME);
        },
      ));
    } catch (e) {
      loading = false;
      Get.back();
      Get.dialog(CustomAlertDialog(
        title: 'Ha ocurrido un error',
        content: 'Tenemos problemas para procesar su solicitud.',
        okText: 'Aceptar',
      ));
    }
  }

  void backPage() {
    if (loading) {
      return;
    }
    Get.dialog(CustomAlertDialog(
      title: 'Salir sin guardar',
      content: '¿Estas seguro que deseas salir sin guardar la excursión?',
      okText: 'Salir',
      cancelOk: true,
      onPressedOk: () {
        Get.back();
        Get.offAllNamed(Routes.HOME);
      },
    ));
  }
}
