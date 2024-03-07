import 'package:discoverrd/app/config/theme_config.dart';
import 'package:discoverrd/app/controllers/auth/register_agency_controller.dart';
import 'package:discoverrd/app/widgets/back_button_widget.dart';
import 'package:discoverrd/app/widgets/rounded_button_widget.dart';
import 'package:discoverrd/app/widgets/upload_photo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegisterAgencyVerifyLicenseStep extends StatelessWidget {
  const RegisterAgencyVerifyLicenseStep(
    {required this.controller, this.onPressedBackBtn, this.onPressedContBtn, this.onChangedDocument});

  final VoidCallback? onPressedBackBtn;
  final VoidCallback? onPressedContBtn;
  final RegisterAgencyController controller;
  final ValueChanged<PickedFile?>? onChangedDocument;
  Widget _pageInfo() {
    return Container(
        child: Column(children: [
      Align(
        alignment: Alignment.center,
        child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: secundaryColors1,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Icon(Icons.badge, size: 80, color: primaryColor)),
      ),
      SizedBox(height: 10.0),
      Center(
          child: Text("Verificar Licencia",
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold))),
      Container(
          padding: EdgeInsets.symmetric(vertical: 18.0),
          child: Text(
              "Tome o sube una foto de la licencia para verificar su cuenta.",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0))),
    ]));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.0),
            Align(
                alignment: Alignment.topLeft,
                child: BackButtonWidget(onPressed: onPressedBackBtn)),
            SizedBox(height: 10.0),
            _pageInfo(),
            Center(child: UploadPhoto(height: 200, width: width * 0.7, full: true, onChanged: onChangedDocument, image: controller.document)),
            SizedBox(height: 15),
            Obx(() => RoundedButton(
                title: "Enviar",
                onPressed: onPressedContBtn,
                loading: controller.loading.value)),
          ]),
    ));
  }
}
