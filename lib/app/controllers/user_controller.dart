import 'package:discoverrd/app/config/app_config.dart';
import 'package:discoverrd/app/models/agency_view.dart';
import 'package:discoverrd/app/models/customer_view.dart';
import 'package:discoverrd/app/models/dtos/agency_dto.dart';
import 'package:discoverrd/app/models/dtos/customer_dto.dart';
import 'package:discoverrd/app/services/auth/user_service.dart';
import 'package:discoverrd/app/widgets/custom_alert_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;

class UserController extends GetxController {
  final RxBool loadData = false.obs;
  final UserService _service = Get.find<UserService>();
  bool loading = false;

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController lastNameCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  Map<int, String> sexs = {1: "Masculino", 2: "Femenino"};
  PickedFile? image;

  RxString defaultImage = "".obs;

  TextEditingController rncCtrl = TextEditingController();
  TextEditingController websiteCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();

  Rx<CustomerDto> customer = CustomerDto().obs;
  Rx<AgencyDto> agency = AgencyDto().obs;

  RxString type = "1".obs;

  void setSexValue(int? value) {
    customer.value = customer.value.copyWith(sex: value);
  }

  void onChangeDate(DateTime? date) {
    customer.value = customer.value.copyWith(birthdate: date);
  }

  //ON
  @override
  void onInit() async {
    super.onInit();
    if (!(Get.parameters["id"]?.isEmpty ?? true)) {
      type.value = Get.parameters["id"]!;
    }
    if (type.value == "1") {
      await _getCustomerUserInfo();
    }
    if (type.value == "2") {
      await _getAgencyUserInfo();
    }
  }

  _getCustomerUserInfo() async {
    loadData.value = true;
    try {
      CustomerView data = await _service.getCustomerByid();
      nameCtrl.text = data.name!;
      lastNameCtrl.text = data.lastName!;
      phoneCtrl.text = data.phone ?? '';
      defaultImage.value = (data.image ?? "") == ""
          ? ""
          : '${AppConfig.API_URL}/file/${data.image}';
      customer.value =
          customer.value.copyWith(birthdate: data.birthdate, sex: data.sex);
      loadData.value = false;
    } catch (e) {
      loadData.value = false;
      Get.dialog(CustomAlertDialog(
        title: 'Ha ocurrido un error',
        content: 'Tenemos problemas para procesar su solicitud.',
        okText: 'Aceptar',
      ));
    }
  }

  _getAgencyUserInfo() async {
    loadData.value = true;
    try {
      AgencyView data = await _service.getAgencyByid();
      nameCtrl.text = data.name!;
      // lastNameCtrl.text = data.lastName!;
      phoneCtrl.text = data.phone!;
      rncCtrl.text = data.rnc!;
      websiteCtrl.text = data.website!;
      addressCtrl.text = data.address!;
      defaultImage.value = (data.image ?? "") == ""
          ? ""
          : '${AppConfig.API_URL}/file/${data.image}';

      loadData.value = false;
    } catch (e) {
      loadData.value = false;
      Get.dialog(CustomAlertDialog(
        title: 'Ha ocurrido un error',
        content: 'Tenemos problemas para procesar su solicitud.',
        okText: 'Aceptar',
      ));
    }
  }

  setImage(PickedFile? file) {
    image = file;
    print(file);
  }

  submit() async {
    if (type.value == "1") {
      await _submitCustomer();
    }
    if (type.value == "2") {
      await _submitAgency();
    }
  }

  _submitCustomer() async {
    loading = true;
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);

    try {
      customer.value = customer.value.copyWith(
          name: nameCtrl.text,
          lastName: lastNameCtrl.text,
          phone: phoneCtrl.text,
          image: image != null
              ? await dio.MultipartFile.fromFile(image!.path,
                  filename: image!.path.split('/').last)
              : null);

      await _service.updateCustomer(customer.value);

      Get.back();
      Get.dialog(CustomAlertDialog(
        title: 'Exito!',
        content: 'Guardado correctamente.',
        okText: 'Aceptar',
        onPressedOk: () {
          Get.back();
          Get.back();
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

  _submitAgency() async {
    loading = true;
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);

    try {
      AgencyDto agency = AgencyDto(
          name: nameCtrl.text,
          address: addressCtrl.text,
          website: websiteCtrl.text,
          phone: phoneCtrl.text,
          image: image != null
              ? await dio.MultipartFile.fromFile(image!.path,
                  filename: image!.path.split('/').last)
              : null);

      await _service.updateAgency(agency);

      Get.back();
      Get.dialog(CustomAlertDialog(
        title: 'Exito!',
        content: 'Guardado correctamente.',
        okText: 'Aceptar',
        onPressedOk: () {
          Get.back();
          Get.back();
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
}
