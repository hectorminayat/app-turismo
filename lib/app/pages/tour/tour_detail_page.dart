import 'package:discoverrd/app/config/app_config.dart';
import 'package:discoverrd/app/config/theme_config.dart';
import 'package:discoverrd/app/controllers/tour_detail_controller.dart';
import 'package:discoverrd/app/models/gallery_item.dart';
import 'package:discoverrd/app/models/tour_view.dart';
import 'package:discoverrd/app/widgets/gallery_photo_view_wrapper.dart';
import 'package:discoverrd/app/widgets/like_button.dart';
import 'package:discoverrd/app/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TourDetailPage extends StatelessWidget {
  TourDetailPage();

  @override
  Widget build(BuildContext context) {
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

    Widget _agencyBox(TourDetailController controller) {
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
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFFf2f3f7)),
            child: Icon(
              icon,
              color: color,
              size: 28,
            )),
        SizedBox(width: 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: TextStyle(fontSize: 10, color: Color(0xFF7C7C7C))),
            Text(value,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)),
          ],
        )
      ]));
    }

    Widget _header(TourView tour, TourDetailController controller) {
      return Container(
        width: Get.width,
        height: Get.height * 0.46,
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  '${AppConfig.API_URL}/file/${tour.images![0]}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [0.0, 0.3],
                        colors: [Colors.black54, Colors.transparent])),
              ),
            ),
            Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _headerIconButton(Icons.arrow_back, () => Get.back()),
                      Row(
                        children: [
                          _headerIconButton(Icons.share, () {
                            controller.share(tour.tour!);
                          }),
                          SizedBox(width: 10),
                          LikeButton(
                            tourId: tour.tour!.id!,
                            initialValue: tour.tour!.like ?? false,
                          )
                        ],
                      )
                    ],
                  ),
                )),
            Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 24),
                  child: Container(
                    height: (Get.height * 0.46) * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tour.tour!.title ?? 'N/A',
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.place,
                              size: 16,
                              color: Colors.white,
                            ),
                            Text(tour.tour!.location ?? 'N/A',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      );
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

    Widget _buildImageSlide(TourDetailController controller) {
      var width = (Get.width - 48.0) / 2.2;
      var height = (160 / 160) * width;
      return _boxContainerTitle(
        "Fotos",
        Container(
          height: height - 16,
          child: ListView(
            scrollDirection: Axis.horizontal, // <-- Like so
            children: <Widget>[
              for (var i = 0; i < controller.galleryItems.length; i++)
                _imageItem(controller.galleryItems[i], i, controller),
            ],
          ),
        ),
      );
    }

    Widget _buildChip(String label) {
      return Chip(
        backgroundColor: primaryColor,
        labelPadding: EdgeInsets.all(2.0),
        label: Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 10),
        ),
        elevation: 0.0,
        padding: EdgeInsets.all(6.0),
      );
    }

    Widget _chipList(
        TourDetailController controller, int categoryId, String title) {
      final list = controller.includeItems
          .where((element) =>
              element.includeCategoryId == categoryId &&
              controller.includes.contains(element.id))
          .toList();
      if (list.length == 0) return Container();
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: <Widget>[
              for (var i = 0; i < list.length; i++) _buildChip(list[i].name!)
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      );
    }

    return GetBuilder<TourDetailController>(
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
                              _header(_.tour.value, _),
                              SizedBox(height: 16.0),
                              _boxContainer(Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _topInfoItem(
                                        Icons.schedule,
                                        Colors.redAccent,
                                        "Duración",
                                        "${_.tour.value.tour!.duration ?? 0} ${(_.tour.value.tour!.durationType ?? 0) == 0 ? 'Horas' : 'Dias'}"),
                                    _topInfoItem(
                                        Icons.star,
                                        Color(0xFFFFD803),
                                        "Rating",
                                        (_.tour.value.tour!.rating ?? 0)
                                            .toString())
                                  ],
                                ),
                              )),
                              SizedBox(height: 16.0),
                              _boxContainerTitle(
                                  "Descripción",
                                  Text(
                                    _.tour.value.tour!.description ?? 'N/A',
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 12),
                                  )),
                              SizedBox(height: 16.0),
                              _buildImageSlide(_),
                              SizedBox(height: 16.0),
                              _boxContainerTitle(
                                  "Requisitos",
                                  Obx(() => _.tour.value.tour!
                                              .tourParticipantsRequirements !=
                                          null
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                              Row(
                                                children: [
                                                  Text("Edad Minima "),
                                                  Text(
                                                    _
                                                        .tour
                                                        .value
                                                        .tour!
                                                        .tourParticipantsRequirements!
                                                        .minAge
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 6.0),
                                              Text(_
                                                      .tour
                                                      .value
                                                      .tour!
                                                      .tourParticipantsRequirements!
                                                      .optional ??
                                                  "")
                                            ])
                                      : Container())),
                              SizedBox(height: 16.0),
                              _boxContainerTitle(
                                  "Que incluye",
                                  Obx(() => _.includes.length > 0
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                              _chipList(_, 1, "Comida"),
                                              _chipList(_, 2, "Bebidas"),
                                              _chipList(_, 3, "Equipo"),
                                              _chipList(_, 4, "Entradas")
                                            ])
                                      : Container())),
                              SizedBox(height: 16.0),
                              _agencyBox(_),
                              SizedBox(height: 100.0),
                            ],
                          ),
                        ),
                      )),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                floatingActionButton: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.16),
                          spreadRadius: 0,
                          blurRadius: 29,
                          offset: Offset(0, 6), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      f.format(double.parse(
                                          "${_.tour.value.tour!.adultPrice ?? '0.00'}")),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: primaryColor,
                                          fontSize: 20),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Text(" / persona",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Color(0xFF4B4B4B))),
                                    )
                                  ])),
                          Container(
                              width: 120,
                              child: RoundedButton(
                                title: "Reservar Ahora",
                                fontSize: 11,
                                onPressed: () {
                                  _.toReserve(_.tour.value);
                                },
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              )));
  }
}
