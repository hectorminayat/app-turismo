import 'package:discoverrd/app/config/app_config.dart';
import 'package:discoverrd/app/models/tour_view.dart';
import 'package:discoverrd/app/widgets/counter.dart';
import 'package:flutter/material.dart';
import 'package:discoverrd/app/controllers/tour_reserve_controller.dart';
import 'package:discoverrd/app/widgets/back_button_widget.dart';
import 'package:discoverrd/app/widgets/rounded_button_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TourReservePage extends StatelessWidget {
  TourReservePage();

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat.currency(locale: "en_US", symbol: '\$');

    Widget _boxItemTitle(String text) {
      return Text(text,
          style: TextStyle(
              fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold));
    }

    void _bottomSheetDate(
        BuildContext context, TourReserveController controller) {
      showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          ),
          context: context,
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Fecha",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close))
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                Container(
                  height: Get.height * 0.3,
                  child: ListView(
                    children: [
                      for (var i = 0;
                          i < controller.tourReserveDates.length;
                          i++)
                        //     Container()

                        ListTile(
                          leading: new Icon(Icons.calendar_today),
                          title: new Text(
                            controller.tourReserveDates[i].text!,
                          ),
                          onTap: () {
                            controller.setDate(controller.tourReserveDates[i]);
                            Navigator.pop(context);
                          },
                        ),
                    ],
                  ),
                ),
              ],
            );
          });
    }

    void _bottomSheetPerson(
        BuildContext context, TourReserveController controller) {
      showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          ),
          context: context,
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Personas",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close))
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                Container(
                  height: Get.height * 0.22,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Adultos",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                              Counter(
                                iconSize: 16,
                                lowerLimit: 1,
                                upperLimit: 10,
                                stepValue: 1,
                                value: controller.invoice.value.adults!,
                                onChanged: controller.changeAdult,
                              ),
                            ]),
                        SizedBox(height: 32),
                        controller.isKid.value
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                    Text(
                                      "Niños",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                    Counter(
                                      iconSize: 16,
                                      lowerLimit: 0,
                                      upperLimit: 10,
                                      stepValue: 1,
                                      value: controller.invoice.value.kids!,
                                      onChanged: controller.changeKid,
                                    ),
                                  ])
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ],
            );
          });
    }

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

    Widget _boxContainerTitle(String title, Widget widget) {
      return _boxContainer(Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _boxItemTitle(title),
          SizedBox(
            height: 8,
          ),
          widget
        ],
      ));
    }

    Widget _topInfoItem(
        IconData icon, Color color, String title, String value) {
      return Container(
          child: Row(children: [
        Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Color(0xFFf2f3f7)),
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
            Text(title,
                style: TextStyle(fontSize: 8, color: Color(0xFF7C7C7C))),
            Text(value,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)),
          ],
        )
      ]));
    }

    Widget _buidHeader(TourView tour) {
      var width = (Get.width - 32.0) * 0.3;
      var height = (140 / 160) * width;
      return _boxContainer(Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width,
              height: height,
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
            SizedBox(width: 8),
            Container(
              width: (Get.width - 32.0) * 0.58,
              height: height,
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

    return GetBuilder<TourReserveController>(
        builder: (_) => Obx(() => _.loading.value
            ? Container(
                color: Colors.white,
                child: Center(child: CircularProgressIndicator()),
              )
            : Scaffold(
                backgroundColor: Color(0xFFf2f3f7),
                body: SafeArea(
                  child: Container(
                      height: Get.height,
                      width: Get.width,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 16.0),
                              Container(
                                  child: Row(
                                children: [
                                  BackButtonWidget(),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 64),
                                      child: Text(
                                        'Solicita una reserva',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                              SizedBox(height: 16.0),
                              _buidHeader(_.tour.value),
                              SizedBox(height: 16.0),
                              _boxContainerTitle(
                                  "Tu viaje",
                                  Container(
                                      child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Fecha",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(height: 2),
                                              Obx(() => Text(
                                                  _.selectedDate.value,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          Color(0xFF636363))))
                                            ],
                                          ),
                                          InkWell(
                                            onTap: () =>
                                                {_bottomSheetDate(context, _)},
                                            child: Text("Editar",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Personas",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(height: 2),
                                              Obx(() => Text(
                                                  "${_.invoice.value.adults} adulto${_.invoice.value.adults! > 1 ? 's' : ''}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          Color(0xFF636363)))),
                                              Obx(() => _.isKid.value
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 4),
                                                      child: Text(
                                                          "${_.invoice.value.kids} niños",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Color(
                                                                  0xFF636363))),
                                                    )
                                                  : Container())
                                            ],
                                          ),
                                          InkWell(
                                            onTap: () => {
                                              _bottomSheetPerson(context, _)
                                            },
                                            child: Text("Editar",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ))),
                              SizedBox(height: 16.0),
                              _boxContainerTitle(
                                  "Detalles del precio",
                                  Obx(() => Container(
                                        child: Column(
                                          children: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      "${f.format(_.adultPrice.value)} x ${_.invoice.value.adults} adulto${_.invoice.value.adults! > 1 ? 's' : ''}",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Color(
                                                              0xFF636363))),
                                                  Text(
                                                      f.format(
                                                          _.adultPrice.value *
                                                              _.invoice.value
                                                                  .adults!),
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Color(
                                                              0xFF636363)))
                                                ]),
                                            _.isKid.value
                                                ? Column(
                                                    children: [
                                                      SizedBox(height: 10),
                                                      Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                "${f.format(_.kidPrice.value)} x ${_.invoice.value.kids} niños",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Color(
                                                                        0xFF636363))),
                                                            Text(
                                                                f.format(_
                                                                        .kidPrice
                                                                        .value *
                                                                    _
                                                                        .invoice
                                                                        .value
                                                                        .kids!),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Color(
                                                                        0xFF636363)))
                                                          ]),
                                                    ],
                                                  )
                                                : Container(),
                                            SizedBox(height: 10),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text("Tarifa de servicio",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Color(
                                                              0xFF636363))),
                                                  Text("\$100.00",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Color(
                                                              0xFF636363)))
                                                ]),
                                            SizedBox(height: 10),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text("Total (DOP)",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black)),
                                                  Text(
                                                      f.format(
                                                          _.calculateAmount()),
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black))
                                                ]),
                                            SizedBox(height: 10),
                                          ],
                                        ),
                                      ))),
                              SizedBox(height: 16.0),
                              _boxContainerTitle(
                                  "Política de cancelación",
                                  Container(
                                      child: Text(
                                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.",
                                          style: TextStyle(fontSize: 12)))),
                              SizedBox(height: 16.0),
                              _boxContainer(Container(
                                  child: Column(children: [
                                Text(
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.",
                                    style: TextStyle(fontSize: 11)),
                                Obx(() => RoundedButton(
                                    disabled: _.invoice.value.date == null,
                                    title: 'Confirmar y pagar',
                                    padding:
                                        EdgeInsets.only(top: 20, bottom: 10),
                                    onPressed: _.payment)),
                              ]))),
                              SizedBox(height: 40.0),
                            ],
                          ),
                        ),
                      )),
                ),
              )));
  }
}
