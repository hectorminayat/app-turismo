import 'package:discoverrd/app/config/theme_config.dart';
import 'package:discoverrd/app/controllers/auth/register_agency_controller.dart';
import 'package:discoverrd/app/widgets/back_button_widget.dart';
import 'package:discoverrd/app/widgets/input_flat_widget.dart';
import 'package:discoverrd/app/widgets/rounded_button_widget.dart';
import 'package:discoverrd/app/widgets/upload_photo.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';

class RegisterAgencyInfoStep extends StatelessWidget {
  const RegisterAgencyInfoStep(
      {required this.controller,
      this.onPressedBackBtn,
      this.onPressedContBtn,
      this.formkey,
      this.onChangedImage});

  final RegisterAgencyController controller;
  final VoidCallback? onPressedBackBtn;
  final VoidCallback? onPressedContBtn;
  final ValueChanged<PickedFile?>? onChangedImage;
  final Key? formkey;

  @override
  Widget build(BuildContext context) {
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
            Text("Información de \nAgencia",
                style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Center(
                child: UploadPhoto(
              circle: true,
              padding: EdgeInsets.only(bottom: 2),
              onChanged: onChangedImage,
              image: controller.image,
            )),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Center(
                child: Text(
                  'Logo',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: secundaryColors2),
                ),
              ),
            ),
            Form(
                key: formkey,
                child: Column(children: [
                  InputFlatWidget(
                      text: 'Dirección',
                      prefixIcon: Icons.place,
                      controller: controller.addressCtrl,
                      validator: RequiredValidator(
                          errorText: 'La dirección es requerida')),
                  InputFlatWidget(
                      text: 'Ciudad',
                      prefixIcon: Icons.location_city,
                      controller: controller.cityCtrl,
                      validator: RequiredValidator(
                          errorText: 'La ciudad es requerida')),
                  InputFlatWidget(
                      text: 'Teléfono',
                      prefixIcon: Icons.phone,
                      keyboardType: TextInputType.number,
                      controller: controller.phoneCtrl,
                      validator: RequiredValidator(
                          errorText: 'El teléfono es requerido')),
                  InputFlatWidget(
                      text: 'Sitio web',
                      prefixIcon: Icons.web,
                      controller: controller.websiteCtrl),
                  RoundedButton(title: "Continuar", onPressed: onPressedContBtn)
                ]))
          ],
        ),
      ),
    );
  }
}
