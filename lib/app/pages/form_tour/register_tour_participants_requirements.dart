import 'package:discoverrd/app/controllers/tour_controller.dart';
import 'package:discoverrd/app/widgets/back_button_widget.dart';
import 'package:discoverrd/app/widgets/input_flat_widget.dart';
import 'package:discoverrd/app/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class RegisterTourParticipantsRequirements extends StatelessWidget {
  RegisterTourParticipantsRequirements();

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
                              BackButtonWidget(
                                  onPressed: _.clearTourMeetingPlace),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(right: 64),
                                child: Text(
                                  "Requisitos para los participantes",
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
                          child: Column(
                            children: [
                              InputFlatWidget(
                                text: 'Edad minima',
                                controller: _.minAgePRCtrl,
                                helpText:
                                    'Establece limites de edad para los participantes, los menores de edad solo pueden asistir acompañados de su tutor.',
                                hintTitle: false,
                                keyboardType: TextInputType.number,
                                validator: RequiredValidator(
                                    errorText: 'El campo es requerido'),
                                onChanged: _.minAngeOnchanged,
                              ),

                              Obx(() => _.showKidAge.value
                                  ? InputFlatWidget(
                                      text: 'Niños hasta',
                                      helpText:
                                          'Se considerarán niños hasta la edad de:',
                                      controller: _.kidAgePRCtrl,
                                      hintTitle: false,
                                      keyboardType: TextInputType.number,
                                      validator: RequiredValidator(
                                          errorText: 'El campo es requerido'))
                                  : Container()),

                              //Description
                              InputFlatWidget(
                                  text: 'Requisitos adicionales (opcional)',
                                  hintText:
                                      'Requisitos adicionales, por ejemplo, si el participante debe tener concimineto de alguna actividad, etc.',
                                  controller: _.optionalPRCtrl,
                                  hintTitle: false,
                                  minLines: 3,
                                  keyboardType: TextInputType.multiline),

                              RoundedButton(
                                  title: 'Guardar',
                                  padding: EdgeInsets.only(top: 40),
                                  onPressed: _.savePartReq)
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            )));
  }
}
