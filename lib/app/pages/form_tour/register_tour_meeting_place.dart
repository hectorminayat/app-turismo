import 'package:discoverrd/app/config/theme_config.dart';
import 'package:discoverrd/app/controllers/tour_controller.dart';
import 'package:discoverrd/app/widgets/back_button_widget.dart';
import 'package:discoverrd/app/widgets/input_flat_widget.dart';
import 'package:discoverrd/app/widgets/rounded_button_widget.dart';
import 'package:discoverrd/app/widgets/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterTourMeetingPlace extends StatelessWidget {
  RegisterTourMeetingPlace();

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
                                  "Punto de encuentro",
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
                              //location
                              InkWell(
                                onTap: _.setMeetingPlaceLocation,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 8),
                                    Text('Ubicación',
                                        style: TextStyle(fontSize: 18)),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.place,
                                          size: 26.0,
                                          color: _.tourMeetingPlaceCache.value
                                                      .address !=
                                                  null
                                              ? Colors.black
                                              : secundaryColors2,
                                        ),
                                        Obx(() => Container(
                                              width: width * 0.85,
                                              child: Text(
                                                  _.tourMeetingPlaceCache.value
                                                          .address ??
                                                      'Seleccione la ubicación de tu excursión',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: _
                                                                  .tourMeetingPlaceCache
                                                                  .value
                                                                  .address !=
                                                              null
                                                          ? FontWeight.w500
                                                          : FontWeight.normal,
                                                      color: _.tourMeetingPlaceCache
                                                                  .value.address !=
                                                              null
                                                          ? Colors.black
                                                          : secundaryColors2)),
                                            ))
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                  ],
                                ),
                              ),
                              Divider(),
                              SizedBox(height: 10),
                              //Description
                              InputFlatWidget(
                                text: 'Descripción',
                                hintText:
                                    'Indicales a los participantes como pueden llegar al lugar y como pueden Identifícarte.',
                                hintTitle: false,
                                minLines: 2,
                                keyboardType: TextInputType.multiline,
                                controller: _.descpTMPCtrl,
                              ),
                              SizedBox(height: 10),
                              TimePicker(
                                title: 'Hora',
                                onChanged: _.setMeetingHour,
                                defaultStringDate:
                                    _.tourMeetingPlaceCache.value.hour,
                              ),
                              RoundedButton(
                                  title: 'Guardar',
                                  padding: EdgeInsets.only(top: 40),
                                  onPressed: _.saveTourMeetingPlace)
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            )));
  }
}
