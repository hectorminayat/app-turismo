import 'package:discoverrd/app/config/theme_config.dart';
import 'package:discoverrd/app/controllers/tour_controller.dart';
import 'package:discoverrd/app/widgets/animated_toggle.dart';
import 'package:discoverrd/app/widgets/back_button_widget.dart';
import 'package:discoverrd/app/widgets/dropdown.dart';
import 'package:discoverrd/app/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterTourDuration extends StatelessWidget {
  RegisterTourDuration();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GetBuilder<TourController>(
        builder: (_) => WillPopScope(
              onWillPop: () async {
                _.clearDuration();
                return false;
              },
              child: Scaffold(
                  body: SafeArea(
                child: Container(
                    height: height,
                    width: width,
                    padding: EdgeInsets.only(
                        top: 10, bottom: 0, left: 15, right: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Row(
                            children: [
                              BackButtonWidget(onPressed: _.clearDuration),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(right: 64),
                                child: Text(
                                  "Duración",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ))
                            ],
                          )),
                          Center(
                            child:
                                Text('Configura la duración de tu excursión.'),
                          ),
                          SizedBox(height: 10),
                          Center(
                              child: Container(
                            child: AnimatedToggle(
                              defaultIndex: _.tour.value.durationType ?? 0,
                              paddingSize: 30,
                              values: ['Un dia', 'Varios dias'],
                              onToggleCallback: (value) {
                                _.setDurationTypeToggle(value);
                              },
                              buttonColor: primaryColor,
                              backgroundColor: secundaryColors1,
                              textColor: const Color(0xFFFFFFFF),
                            ),
                          )),
                          Obx(() => Column(children: [
                                _.durationTypeToggle.value == 0
                                    ? Dropdown<int>(
                                        items: _.durtationHours,
                                        title: 'Horas',
                                        helpText:
                                            'Seleccione cuantas horas tendra la excursión.',
                                        onChanged: _.setDurationValue,
                                        value: _.durationValue.value == 0
                                            ? null
                                            : _.durationValue.value)
                                    : Dropdown<int>(
                                        items: _.durtationDays,
                                        title: 'Dias',
                                        helpText:
                                            'Seleccione cuantos dias tendra la excursión.',
                                        onChanged: _.setDurationValue,
                                        value: _.durationValue.value == 0
                                            ? null
                                            : _.durationValue.value),
                                RoundedButton(
                                    title: 'Guardar',
                                    padding: EdgeInsets.only(top: 40),
                                    onPressed: _.saveDuracion)
                              ])),
                        ],
                      ),
                    )),
              )),
            ));
  }
}
