import 'package:discoverrd/app/controllers/user_controller.dart';
import 'package:discoverrd/app/widgets/back_button_widget.dart';
import 'package:discoverrd/app/widgets/date_picker.dart';
import 'package:discoverrd/app/widgets/dropdown.dart';
import 'package:discoverrd/app/widgets/input_flat_widget.dart';
import 'package:discoverrd/app/widgets/rounded_button_widget.dart';
import 'package:discoverrd/app/widgets/upload_photo_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GetBuilder<UserController>(
        builder: (_) => Obx(() => _.loadData.value
            ? Container(
                color: Colors.white,
                child: Center(child: CircularProgressIndicator()),
              )
            : Scaffold(
                body: GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: SafeArea(
                        child: Container(
                            height: height,
                            width: width,
                            padding: EdgeInsets.only(
                                top: 10, left: 15, right: 15, bottom: 0),
                            child: SingleChildScrollView(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  Container(
                                      child: Row(
                                    children: [
                                      BackButtonWidget(),
                                      Expanded(
                                          child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 64),
                                        child: Text(
                                          "Editar perfil",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ))
                                    ],
                                  )),
                                  // BackButtonWidget(),
                                  // Text("Editar mi cuenta",
                                  //     style: TextStyle(
                                  //         fontSize: 28.0,
                                  //         fontWeight: FontWeight.bold)),
                                  Center(
                                      child: UploadPhotoProfile(
                                    onChanged: _.setImage,
                                    defaultImage: _.defaultImage.value,
                                    padding: EdgeInsets.only(bottom: 2),

                                    //     onChanged: onChangedImage,
                                    //   image: controller.image,
                                  )),
                                  SizedBox(height: 10),
                                  Obx(() => _.type.value == "1"
                                      ? Column(
                                          children: [
                                            InputFlatWidget(
                                                text: 'Nombre',
                                                hintText: 'Nombres',
                                                controller: _.nameCtrl,
                                                hintTitle: false),
                                            InputFlatWidget(
                                                text: 'Apellido',
                                                hintText: 'Apellidos',
                                                controller: _.lastNameCtrl,
                                                hintTitle: false),
                                            Dropdown<int>(
                                                items: _.sexs,
                                                title: 'Sexo',
                                                onChanged: _.setSexValue,
                                                value: (_.customer.value.sex ??
                                                            0) ==
                                                        0
                                                    ? null
                                                    : _.customer.value.sex),
                                            InputFlatWidget(
                                                text: 'Telefono',
                                                hintText: '809-456-5460',
                                                controller: _.phoneCtrl,
                                                hintTitle: false),
                                            DatePicker(
                                              title: 'Cumpleaños',
                                              onChanged: _.onChangeDate,
                                              defaultDate:
                                                  _.customer.value.birthdate,
                                            ),
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            InputFlatWidget(
                                                text: 'Nombre',
                                                hintText: 'Nombre',
                                                controller: _.nameCtrl,
                                                hintTitle: false),
                                            InputFlatWidget(
                                                text: 'RNC',
                                                hintText: '000000',
                                                controller: _.rncCtrl,
                                                enable: false,
                                                hintTitle: false),
                                            InputFlatWidget(
                                                text: 'Telefono',
                                                hintText: '809-456-5460',
                                                controller: _.phoneCtrl,
                                                hintTitle: false),
                                            InputFlatWidget(
                                                text: 'Dirección',
                                                hintText: '809-456-5460',
                                                controller: _.addressCtrl,
                                                hintTitle: false),
                                            InputFlatWidget(
                                                text: 'Sitio Web',
                                                hintText: 'www.misitioweb.com',
                                                controller: _.websiteCtrl,
                                                hintTitle: false),
                                          ],
                                        )),
                                  Divider(),
                                  RoundedButton(
                                      title: 'Guardar',
                                      padding:
                                          EdgeInsets.only(top: 20, bottom: 20),
                                      onPressed: _.submit),
                                ]))))))));
  }
}
