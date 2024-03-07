import 'package:discoverrd/app/config/theme_config.dart';
import 'package:discoverrd/app/controllers/tour_controller.dart';
import 'package:discoverrd/app/models/tour_dates.dart';
import 'package:discoverrd/app/models/tour_dates_rage.dart';
import 'package:discoverrd/app/widgets/back_button_widget.dart';
import 'package:discoverrd/app/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class RegisterTourDates extends StatelessWidget {
  RegisterTourDates();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    Widget _buildDateItem(DateTime date) {
      String text = Jiffy(date).yMMMMd;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Container(
            width: width,
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
                color: secundaryColors1,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Icon(Icons.calendar_today),
                SizedBox(width: 8),
                Text(text,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              ],
            )),
      );
    }

    Widget _buildRangeDateItem(DateTime? startDate, DateTime? endDate) {
      if (startDate == null || endDate == null) return Container();
      String start = Jiffy(startDate).yMMMMd;
      String end = Jiffy(endDate).yMMMMd;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Container(
            width: width,
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
                color: secundaryColors1,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Icon(Icons.calendar_today),
                SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Incio: $start',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    SizedBox(height: 2),
                    Text('Fin: $end',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                  ],
                )
              ],
            )),
      );
    }

    return GetBuilder<TourController>(
        builder: (_) => WillPopScope(
              onWillPop: () async {
                _.clearDates();
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
                              BackButtonWidget(onPressed: _.clearDates),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(right: 64),
                                child: Text(
                                  "Fechas de la excursión",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ))
                            ],
                          )),
                          Center(
                            child: Text(
                                'Configura el calendario para tu excursión.'),
                          ),
                          SizedBox(height: 10),
                          Center(
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: secundaryColors1),
                                  padding: EdgeInsets.all(6),
                                  child: SfDateRangePicker(
                                    initialSelectedDates:
                                        _.initialSelectedDates,
                                    initialSelectedRanges:
                                        _.initialSelectedRanges,
                                    controller: _.dateRangeCtrl,
                                    backgroundColor: secundaryColors1,
                                    monthViewSettings:
                                        DateRangePickerMonthViewSettings(
                                            firstDayOfWeek: 1),
                                    selectionColor: primaryColor,
                                    enablePastDates: false,
                                    onSelectionChanged: (args) {
                                      if (args.value is List<PickerDateRange>) {
                                        final List<PickerDateRange>
                                            selectedRanges = args.value;
                                        _.tourDatesRangeCache.clear();
                                        selectedRanges.forEach((range) {
                                          _.tourDatesRangeCache.add(
                                              TourDatesRage(
                                                  startDate: range.startDate,
                                                  endDate: range.endDate));
                                        });
                                      } else if (args.value is List<DateTime>) {
                                        final List<DateTime> selectedDates =
                                            args.value;
                                        _.tourDatesCache.clear();
                                        selectedDates.forEach((date) {
                                          _.tourDatesCache
                                              .add(TourDates(date: date));
                                          print(_.tourDatesCache.length);
                                        });
                                      }
                                    },
                                    selectionMode:
                                        (_.tour.value.durationType ?? 0) == 0
                                            ? DateRangePickerSelectionMode
                                                .multiple
                                            : DateRangePickerSelectionMode
                                                .multiRange,
                                  ))),
                          SizedBox(height: 10),
                          Obx(() => _.tourDatesCache.length > 0 &&
                                  (_.tour.value.durationType ?? 0) == 0
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (var i = 0;
                                        i < _.tourDatesCache.length;
                                        i++)
                                      _buildDateItem(_.tourDatesCache[i].date!)
                                  ],
                                )
                              : Container()),
                          Obx(() => _.tourDatesRangeCache.length > 0 &&
                                  (_.tour.value.durationType ?? 0) == 1
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (var i = 0;
                                        i < _.tourDatesRangeCache.length;
                                        i++)
                                      _buildRangeDateItem(
                                          _.tourDatesRangeCache[i].startDate,
                                          _.tourDatesRangeCache[i].endDate)
                                  ],
                                )
                              : Container()),
                          RoundedButton(
                              title: 'Guardar',
                              padding: EdgeInsets.only(top: 40),
                              onPressed: _.saveDates)
                        ],
                      ),
                    )),
              )),
            ));
  }
}
