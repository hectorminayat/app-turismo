import 'dart:ui';

import 'package:discoverrd/app/config/app_config.dart';
import 'package:discoverrd/app/config/theme_config.dart';
import 'package:discoverrd/app/controllers/tour_detail_controller.dart';
import 'package:discoverrd/app/controllers/tour_reserve_detail_controller.dart';
import 'package:discoverrd/app/models/gallery_item.dart';
import 'package:discoverrd/app/models/tour_reserve_view.dart';
import 'package:discoverrd/app/widgets/back_button_widget.dart';
import 'package:discoverrd/app/widgets/gallery_photo_view_wrapper.dart';
import 'package:discoverrd/app/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TourReserveDetailPage extends StatelessWidget {
  TourReserveDetailPage();

  @override
  Widget build(BuildContext context) {
    late GoogleMapController mapController;

    final LatLng _center = const LatLng(37.42796133580664, -122.085749655962);

    void _onMapCreated(GoogleMapController controller) {
      mapController = controller;
    }

    var f = NumberFormat.currency(locale: "en_US", symbol: '\$');

    Widget _boxItemTitle(String text) {
      return Text(text,
          style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.w500));
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

    Widget _agencyBox(TourReserveDetailController controller) {
      return _boxContainer(Row(
        children: [
          Container(
              width: 76.0,
              height: 76.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(
                          "${AppConfig.API_URL}/file/${controller.agency.value.image}")))),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.agency.value.name ?? 'N/A',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: primaryColor.withOpacity(0.5))),
                          Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: primaryColor),
                              child: Center(
                                  child: Icon(Icons.done,
                                      color: Colors.white, size: 16))),
                        ],
                      ),
                      SizedBox(width: 2),
                      Text(
                        "Verificada",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(width: 10),
                  Row(children: [
                    Icon(
                      Icons.star,
                      size: 34,
                      color: Color(0xFFFFD803),
                    ),
                    SizedBox(width: 2),
                    Text("4.6",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18))
                  ])
                ],
              )
            ],
          )
        ],
      ));
    }

    Widget _headerIconButton(IconData icon, GestureTapCallback onTap) {
      return Container(
        child: Material(
          color: Colors.transparent,
          shape: CircleBorder(),
          child: InkWell(
            customBorder: CircleBorder(),
            splashColor: primaryColor,
            onTap: onTap,
            child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.8)),
                child: Icon(icon, color: primaryColor, size: 26)),
          ),
        ),
      );
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

    Widget _buidHeader(
        TourReserveView tour, TourReserveDetailController controller) {
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

    void open(
        BuildContext context, final int index, List<GalleryItem> galleryItems) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GalleryPhotoViewWrapper(
            galleryItems: galleryItems,
            backgroundDecoration: const BoxDecoration(
              color: Colors.black,
            ),
            initialIndex: index,
            scrollDirection: Axis.horizontal,
          ),
        ),
      );
    }

    Widget _imageItem(
        GalleryItem image, int index, TourDetailController controller) {
      var width = (Get.width - 48.0) / 2.2;
      var height = (160 / 160) * width;
      return GestureDetector(
        onTap: () {
          open(context, index, controller.galleryItems);
        },
        child: Hero(
          tag: image.id,
          child: Container(
            width: width,
            height: height,
            padding: EdgeInsets.only(right: 16),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                image.url,
                // 'https://www.diariolibre.com/binrepository/819x1024/0c0/0d0/none/10904/SBFN/rio-partido_13770292_20200428154233.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );
    }

    return GetBuilder<TourReserveDetailController>(
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
                                        'Mi reserva',
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
                              Obx(() => _.finished.value
                                  ? Column(
                                      children: [
                                        _boxContainer(Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "FINALIZADO",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 24,
                                                  color: Colors.black54),
                                            ),
                                            Obx(() => Container(
                                                  width: Get.width * 0.35,
                                                  child: RoundedButton(
                                                    disabled:
                                                        _.checkRating.value,
                                                    title: 'CALIFICAR',
                                                    onPressed: () =>
                                                        _.feedback(),
                                                  ),
                                                ))
                                          ],
                                        )),
                                        SizedBox(height: 16.0),
                                      ],
                                    )
                                  : Container()),
                              _buidHeader(_.tour.value, _),
                              SizedBox(height: 16.0),
                              _agencyBox(_),
                              SizedBox(height: 16.0),
                              _boxContainerTitle(
                                  'Fecha',
                                  Column(
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Icon(Icons.calendar_today),
                                            SizedBox(width: 10),
                                            Text(
                                                _.tour.value.tour!
                                                            .durationType ==
                                                        0
                                                    ? Jiffy(_.tour.value
                                                            .invoice!.date)
                                                        .yMMMMd
                                                    : '${Jiffy(_.tour.value.invoice!.date).yMMMMd} - ${Jiffy(_.tour.value.invoice!.date2).yMMMMd}',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                    ],
                                  )),
                              SizedBox(height: 16),
                              _boxContainerTitle(
                                  "Punto de encuentro",
                                  Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.schedule, size: 22),
                                            SizedBox(width: 6),
                                            Text(
                                                _.tour.value.tour!
                                                    .tourMeetingPlace!.hour!,
                                                style: TextStyle(fontSize: 20))
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        _.tour.value.tour!.tourMeetingPlace!
                                                    .description !=
                                                null
                                            ? Column(
                                                children: [
                                                  Text(
                                                      _
                                                              .tour
                                                              .value
                                                              .tour!
                                                              .tourMeetingPlace!
                                                              .description ??
                                                          '',
                                                      style: TextStyle(
                                                          fontSize: 14)),
                                                  SizedBox(height: 10),
                                                ],
                                              )
                                            : Container(),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Icon(Icons.place),
                                            SizedBox(width: 6),
                                            Container(
                                              width: Get.width * 0.7,
                                              child: Text(
                                                  _
                                                      .tour
                                                      .value
                                                      .tour!
                                                      .tourMeetingPlace!
                                                      .address!,
                                                  style:
                                                      TextStyle(fontSize: 12)),
                                            ),
                                          ],
                                        ),
                                        // Container(
                                        //     width: 300,
                                        //     height: 300,
                                        //     padding: EdgeInsets.all(4),
                                        //     child: GoogleMap(
                                        //       onMapCreated: _onMapCreated,
                                        //       initialCameraPosition:
                                        //           CameraPosition(
                                        //         target: _center,
                                        //         zoom: 11.0,
                                        //       ),
                                        //     ))
                                      ],
                                    ),
                                  )),
                              SizedBox(height: 16),
                              _boxContainerTitle(
                                  "Factura",
                                  Obx(() => Container(
                                        child: Column(
                                          children: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      "${f.format(_.tour.value.tour!.adultPrice!)} x ${_.tour.value.invoice!.adults} adulto${_.tour.value.invoice!.adults! > 1 ? 's' : ''}",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Color(
                                                              0xFF636363))),
                                                  Text(
                                                      f.format(_
                                                              .tour
                                                              .value
                                                              .tour!
                                                              .adultPrice! *
                                                          _.tour.value.invoice!
                                                              .adults!),
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Color(
                                                              0xFF636363)))
                                                ]),
                                            _.tour.value.tour!.enableKidPrice!
                                                ? Column(
                                                    children: [
                                                      SizedBox(height: 10),
                                                      Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                "${f.format(_.tour.value.tour!.kidPrice!)} x ${_.tour.value.invoice!.kids} niños",
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
                                                                        .tour
                                                                        .value
                                                                        .tour!
                                                                        .kidPrice! *
                                                                    _
                                                                        .tour
                                                                        .value
                                                                        .invoice!
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
                                                      f.format(_.tour.value
                                                          .invoice!.amount),
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
                              SizedBox(height: 100.0),
                            ],
                          ),
                        ),
                      )),
                ),
              )));
  }
}
