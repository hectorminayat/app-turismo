import 'package:discoverrd/app/config/theme_config.dart';
import 'package:discoverrd/app/controllers/search_controller.dart';
import 'package:discoverrd/app/models/tour_dates_rage.dart';
import 'package:discoverrd/app/widgets/back_button_widget.dart';
import 'package:discoverrd/app/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SearchDates extends StatelessWidget {
  SearchDates();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GetBuilder<SearchController>(
        builder: (_) => WillPopScope(
              onWillPop: () async {
                _.clearDates();
                return true;
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
                              BackButtonWidget(onPressed: _.clearDates),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(right: 64),
                                child: Text(
                                  "Fecha de la excursión",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ))
                            ],
                          )),
                          SizedBox(height: 10),
                          Center(
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: secundaryColors1),
                                  padding: EdgeInsets.all(6),
                                  child: SfDateRangePicker(
                                    controller: _.dateRangeCtrl,
                                    backgroundColor: secundaryColors1,
                                    monthViewSettings:
                                        DateRangePickerMonthViewSettings(
                                            firstDayOfWeek: 1),
                                    selectionColor: primaryColor,
                                    enablePastDates: false,
                                    onSelectionChanged: (args) {
                                      if (args.value is PickerDateRange) {
                                        final PickerDateRange range =
                                            args.value;
                                        _.tourDatesRangeCache.value =
                                            TourDatesRage(
                                                startDate: range.startDate,
                                                endDate: range.endDate);
                                      }
                                    },
                                    selectionMode:
                                        DateRangePickerSelectionMode.range,
                                  ))),
                          SizedBox(height: 10),
                          RoundedButton(
                              title: 'Aceptar',
                              padding: EdgeInsets.only(top: 40),
                              onPressed: _.saveDates)
                        ],
                      ),
                    )),
              )),
            ));
  }
}
