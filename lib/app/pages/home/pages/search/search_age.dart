import 'package:discoverrd/app/controllers/search_controller.dart';
import 'package:discoverrd/app/widgets/back_button_widget.dart';
import 'package:discoverrd/app/widgets/input_flat_widget.dart';
import 'package:discoverrd/app/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class SearchAge extends StatelessWidget {
  SearchAge();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GetBuilder<SearchController>(
        builder: (_) => Scaffold(
                body: SafeArea(
              child: Container(
                  height: height,
                  width: width,
                  padding:
                      EdgeInsets.only(top: 10, bottom: 0, left: 15, right: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Row(
                          children: [
                            BackButtonWidget(),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(right: 64),
                              child: Text(
                                "Edad",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ))
                          ],
                        )),
                        SizedBox(height: 10),
                        Container(
                          child: InputFlatWidget(
                            text: 'Edad minima',
                            controller: _.minAgePRCtrl,
                            helpText:
                                'Los menores de edad solo pueden asistir acompañados de su tutor.',
                            hintTitle: false,
                            keyboardType: TextInputType.number,
                            validator: RequiredValidator(
                                errorText: 'El campo es requerido'),
                          ),
                        ),
                        SizedBox(height: 10),
                        RoundedButton(
                            title: 'Aceptar',
                            padding: EdgeInsets.only(top: 40),
                            onPressed: _.saveAge)
                      ],
                    ),
                  )),
            )));
  }
}
