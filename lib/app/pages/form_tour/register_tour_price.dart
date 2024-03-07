import 'package:discoverrd/app/controllers/tour_controller.dart';
import 'package:discoverrd/app/widgets/back_button_widget.dart';
import 'package:discoverrd/app/widgets/input_flat_widget.dart';
import 'package:discoverrd/app/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class RegisterTourPrice extends StatelessWidget {
  RegisterTourPrice();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GetBuilder<TourController>(
        builder: (_) => Scaffold(
                body: SafeArea(
              child: Container(
                  height: height,
                  width: width,
                  padding: EdgeInsets.only(top: 10, bottom: 0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                              child: Row(
                            children: [
                              BackButtonWidget(),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(right: 64),
                                child: Text(
                                  "Configuracion de precios",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ))
                            ],
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, top: 15, right: 15),
                          child: Obx(() {
                            return Column(children: [
                              InputFlatWidget(
                                  text: _.showKidAge.value
                                      ? 'Adultos'
                                      : 'Precio por persona',
                                  helpText: _.showKidAge.value
                                      ? 'Cada adulto paga:'
                                      : null,
                                  hintTitle: false,
                                  keyboardType: TextInputType.number,
                                  controller: _.adultPriceCtrl,
                                  validator: RequiredValidator(
                                      errorText: 'El campo es requerido')),
                              _.showKidAge.value
                                  ? InputFlatWidget(
                                      text: 'Niños',
                                      helpText:
                                          ' Cada niño hasta la edad de ${_.tourParticipantsRequirements.value.kidAge} años paga:',
                                      hintTitle: false,
                                      keyboardType: TextInputType.number,
                                      controller: _.kidPriceCtrl,
                                      validator: RequiredValidator(
                                          errorText: 'El campo es requerido'))
                                  : Container(),
                              RoundedButton(
                                  title: 'Guardar',
                                  padding: EdgeInsets.only(top: 40),
                                  onPressed: _.savePrice)
                            ]);
                          }),
                        )
                      ],
                    ),
                  )),
            )));
  }
}
