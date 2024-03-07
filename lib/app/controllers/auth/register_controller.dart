import 'package:discoverrd/app/models/auth/customer_user.dart';
import 'package:discoverrd/app/routes/app_pages.dart';
import 'package:discoverrd/app/services/auth/user_service.dart';
import 'package:discoverrd/app/widgets/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final UserService _service = Get.find<UserService>();

  RxBool loading = false.obs;
  RxBool disableSubmit = false.obs;

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController lastNameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  goToPage(String page) {
    Get.toNamed(page);
  }

  submit() async {
    try {
      loading.value = true;
      CustomerUser customerUser = CustomerUser(
          name: nameCtrl.text,
          lastName: lastNameCtrl.text,
          email: emailCtrl.text,
          password: passwordCtrl.text);
      await _service.registerCustomer(customerUser);
      loading.value = false;
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      if (e.toString() == "ExistEmail") {
        Get.dialog(CustomAlertDialog(
          title: 'El correo electrónico se usa en una cuenta',
          content: 'Puedes iniciar sesión en la cuenta asociada con ese correo electrónico.',
          okText: 'Aceptar',
        ));
      }
      else {
        Get.dialog(CustomAlertDialog(
            title: 'Ha ocurrido un error',
            content: 'Tenemos problemas para crear la nueva cuenta.',
            okText: 'Aceptar',
          ));
        loading.value = false;
      }
    }
  }
}
