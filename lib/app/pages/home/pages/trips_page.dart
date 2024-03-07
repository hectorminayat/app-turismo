import 'dart:ui';

import 'package:discoverrd/app/config/app_config.dart';
import 'package:discoverrd/app/config/theme_config.dart';
import 'package:discoverrd/app/controllers/home_controller.dart';
import 'package:discoverrd/app/models/tour_reserve_view.dart';
import 'package:discoverrd/app/models/tour_view.dart';
import 'package:discoverrd/app/widgets/like_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class TripsPage extends StatelessWidget {
  TripsPage({required this.controller});
  final HomeController controller;

  Widget _boxContainer(Widget widget) {
    return Container(
        padding: EdgeInsets.all(16),
        width: Get.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: widget);
  }

  Widget _topInfoItem(IconData icon, Color color, String title, String value) {
    return Container(
        child: Row(children: [
      Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6), color: Color(0xFFf2f3f7)),
          child: Icon(
            icon,
            color: color,
            size: 20,
          )),
      SizedBox(width: 6),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 8, color: Color(0xFF7C7C7C))),
          Text(value,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
        ],
      )
    ]));
  }

  Widget _buildTour(TourReserveView tour) {
    var width = (Get.width - 30.0) * 0.3;
    var height = (140 / 160) * width;
    return _boxContainer(Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              width: width,
              height: height + 10,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(20.0)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  '${AppConfig.API_URL}/file/${tour.images![0]}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          Container(
            width: (Get.width - 30.0) * 0.58,
            height: height + 20,
            child: Container(
              padding: EdgeInsets.only(top: 4),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tour.tour!.title!,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.place,
                              size: 14,
                            ),
                            Text(tour.tour!.location!,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                )),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    Container(
                        child: Text(
                      "${tour.tour!.durationType == 0 ? Jiffy(tour.invoice!.date).yMMMMd : "${Jiffy(tour.invoice!.date).yMMMMd} - ${Jiffy(tour.invoice!.date2).yMMMMd}"}",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    )),
                    SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _topInfoItem(
                            Icons.schedule,
                            Colors.redAccent,
                            "Duración",
                            "${tour.tour!.duration ?? 0} ${(tour.tour!.durationType ?? 0) == 0 ? 'Horas' : 'Dias'}"),
                        SizedBox(
                          width: 26,
                        ),
                        //"${_.tour.value.tour!.duration ?? 0} ${(_.tour.value.tour!.durationType ?? 0) == 0 ? 'Horas' : 'Dias'}"),
                        _topInfoItem(Icons.star, Color(0xFFFFD803), "Rating",
                            (tour.tour!.rating ?? 0).toString())
                      ],
                    ),
                  ]),
            ),
          )
        ]));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color(0xFFf2f3f7),
        body: SafeArea(
            child: Container(
                color: Color(0xFFf2f3f7),
                height: height,
                width: width,
                padding:
                    EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: Text(
                        "Mis Viajes",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      )),
                      SizedBox(
                        height: 16,
                      ),
                      Expanded(
                        child: Obx(() => controller.loading.value
                            ? Container(
                                child:
                                    Center(child: CircularProgressIndicator()))
                            : Container(
                                width: Get.width,
                                child: Obx(
                                  () => controller.reservesTours.length == 0
                                      ? Container()
                                      : SingleChildScrollView(
                                          child: Column(
                                          children: [
                                            for (var item
                                                in controller.reservesTours)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 20),
                                                child: InkWell(
                                                    onTap: () {
                                                      controller
                                                          .toViewReserve(item);
                                                    },
                                                    child: _buildTour(item)),
                                              )
                                          ],
                                        )),
                                ))),
                      ),
                    ]))));
  }
}
