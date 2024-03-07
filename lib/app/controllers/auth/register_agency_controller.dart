import 'package:discoverrd/app/models/auth/agency_user.dart';
import 'package:discoverrd/app/models/auth/check_user_agency.dart';
import 'package:discoverrd/app/routes/app_pages.dart';
import 'package:discoverrd/app/services/auth/user_service.dart';
import 'package:discoverrd/app/widgets/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;

class RegisterAgencyController extends GetxController {
  final UserService _service = Get.find<UserService>();
  final PageController pageController = PageController();

  RxBool loading = false.obs;
  RxBool disableSubmit = false.obs;
  
  //step1
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController rncCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  //step2
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController cityCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController websiteCtrl = TextEditingController();
  
  PickedFile? document;
  PickedFile? image;

  goToPage(String page) {
    Get.toNamed(page);
  }

  setDocument(PickedFile? file) {
    document = file;
    print('image doc');
    print(file);
    update();
  }

   setImage(PickedFile? file) {
    image = file;
    print('image img');
    print(file);
    update();
  }
  
  checkUser() async {
    try {
      loading.value = true;
      await _service.checkUserAgency(CheckUserAgency(email: emailCtrl.text, rnc: rncCtrl.text));
        
      loading.value = false;
      pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.easeIn);

    } catch(e) {
      print(e);
      if(e.toString() =="existEmail") {
        Get.dialog(CustomAlertDialog(
          title: 'El correo electrónico se usa en una cuenta',
          content: 'Puedes iniciar sesión en la cuenta asociada con ese correo electrónico.',
          okText: 'Aceptar'
        ));
      }
      else if(e.toString() =="existRNC") {
        Get.dialog(CustomAlertDialog(
          title: 'El RNC se usa en una cuenta',
          content: 'Puedes iniciar sesión en la cuenta asociada con ese RNC.',
          okText: 'Aceptar'
        ));
      }
      else {
        Get.dialog(CustomAlertDialog(
          title: 'Ha ocurrido un error',
          content: 'Tenemos problemas para crear la nueva cuenta.',
          okText: 'Aceptar',
        ));
      }
      loading.value = false;
    }
  }
  goToRegisterPage() {
    Get.back();
  }

  goToLoginPage(){
    Get.toNamed(Routes.LOGIN);
  }
  submit() async {
    try {
      
      if (document == null) {
        Get.dialog(CustomAlertDialog(
          title: 'Documento requerido',
          content: 'Es nencesario subir la licencia para completar el registro.',
          okText: 'Aceptar',
        ));
        return;
      }

      loading.value = true;
      AgencyUser agencyUser = AgencyUser(
        name: nameCtrl.text,
        rnc: rncCtrl.text,
        address:  addressCtrl.text,
        city:  cityCtrl.text,
        phone: phoneCtrl.text,
        website:  websiteCtrl.text,
        email: emailCtrl.text,
        password: passwordCtrl.text,
        document: document != null ? await dio.MultipartFile.fromFile(document!.path, filename: document!.path.split('/').last) : null,
        image: image != null ? await dio.MultipartFile.fromFile(image!.path, filename: image!.path.split('/').last) : null
      );

      await _service.registerAgency(agencyUser);
      loading.value = false;
        pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.easeIn);
      
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
  goToLogin() {
    Get.offAllNamed(Routes.LOGIN);
  }
}
