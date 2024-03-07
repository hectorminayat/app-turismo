import 'package:discoverrd/app/config/app_config.dart';
import 'package:discoverrd/app/config/theme_config.dart';
import 'package:discoverrd/app/controllers/search_controller.dart';
import 'package:discoverrd/app/models/tour_view.dart';
import 'package:discoverrd/app/widgets/back_button_widget.dart';
import 'package:discoverrd/app/widgets/like_button.dart';
import 'package:discoverrd/app/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class SearchPage extends StatelessWidget {
  const SearchPage();

  Widget _buildDrawer(SearchController _) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  tooltip: 'Close',
                  onPressed: () {
                    Get.back();
                  },
                ),
                Text(
                  "Filtar",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                  onPressed: _.clear,
                  child: const Text('Limpiar'),
                ),
              ],
            ),
          ),
          Divider(),
          InkWell(
            onTap: _.setLocation,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: Get.width * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => (Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _.location.value != ''
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Ubicación',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                      Container(
                                        width: Get.width * 0.7,
                                        child: Text(_.location.value,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(fontSize: 13)),
                                      )
                                    ],
                                  )
                                : Text('Ubicación',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                            Icon(Icons.chevron_right)
                          ],
                        ))),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: _.setDates,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => (Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _.tourDatesRange.value.startDate != null &&
                                  _.tourDatesRange.value.endDate != null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Fecha',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        "Desde: ${Jiffy(_.tourDatesRange.value.startDate).yMMMMd}",
                                        style: TextStyle(fontSize: 13)),
                                    Text(
                                        "Hasta: ${Jiffy(
                                          _.tourDatesRange.value.endDate,
                                        ).yMMMMd}",
                                        style: TextStyle(fontSize: 13)),
                                  ],
                                )
                              : Text('Fecha',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                          Icon(Icons.chevron_right)
                        ],
                      ))),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: _.setAge,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: Get.width * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => (Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _.age.value != 0
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Edad',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                      Container(
                                        width: Get.width * 0.7,
                                        child: Text(_.age.value.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(fontSize: 13)),
                                      )
                                    ],
                                  )
                                : Text('Edad',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                            Icon(Icons.chevron_right)
                          ],
                        ))),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: _.setPrice,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                width: Get.width * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => (Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _.minPrice.value != 0 || _.maxPrice.value != 0
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Precio',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                      Container(
                                        width: Get.width * 0.7,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                                'RD\$ ${(_.minPrice.value == 0 ? "--" : _.minPrice.value.toStringAsFixed(2))}'),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: Text('-'),
                                            ),
                                            Text(
                                                'RD\$ ${(_.maxPrice.value == 0 ? "--" : _.maxPrice.value.toStringAsFixed(2))}'),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                : Text('Precio',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                            Icon(Icons.chevron_right)
                          ],
                        ))),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
          Divider(),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: RoundedButton(
                title: 'Buscar',
                padding: EdgeInsets.only(top: 40),
                onPressed: _.submit),
          )
        ],
      )),
    );
  }

  Widget _buildTour(TourView tour, SearchController controller) {
    return InkWell(
      onTap: () {
        controller.toDetail(tour);
      },
      child: Center(
        child: Container(
          width: Get.width * 0.8,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Get.width * 0.8,
                height: Get.height * 0.20,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network(
                          '${AppConfig.API_URL}/file/${tour.images![0]}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LikeButton(
                          tourId: tour.tour!.id!,
                          large: false,
                          initialValue: tour.tour!.like!,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Container(
                width: (Get.width * 0.55) - 15,
                child: Text(
                  tour.tour!.title ?? 'N/A',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              Container(
                width: (Get.width * 0.9) - 15,
                child: Row(
                  children: [
                    Icon(
                      Icons.place,
                      size: 16,
                      color: secundaryColors2,
                    ),
                    Container(
                      width: ((Get.width * 0.9) - 15) * 0.6,
                      child: Text(
                        tour.tour!.location ?? 'N/A',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(fontSize: 12, color: secundaryColors2),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 34,
                        ),
                        Text((tour.tour!.rating ?? 0).toString(),
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GetBuilder<SearchController>(
        builder: (_) => Scaffold(
            key: _.scaffoldKey,
            endDrawer: _buildDrawer(_),
            body: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: SafeArea(
                    child: Container(
                        height: height,
                        width: width,
                        padding: EdgeInsets.only(
                            top: 10, left: 15, right: 15, bottom: 0),
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
                                      "Buscar",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ))
                                ],
                              )),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                width: Get.width,
                                height: 50.0,
                                //padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                child: Material(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: _.openDrawer,
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.search,
                                            color: primaryColor,
                                            size: 28,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "Buscar destino...",
                                            style: TextStyle(
                                                color: secundaryColors2),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Expanded(
                                child: Obx(() => _.loading.value
                                    ? Container(
                                        child: Center(
                                            child: CircularProgressIndicator()))
                                    : Container(
                                        width: Get.width,
                                        child: Obx(
                                          () => _.tours.length == 0
                                              ? Container()
                                              : SingleChildScrollView(
                                                  child: Column(
                                                  children: [
                                                    for (var item in _.tours)
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 20),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 20),
                                                          child: _buildTour(
                                                              item, _),
                                                        ),
                                                      )
                                                  ],
                                                )
                                                  //  ListView.builder(
                                                  //     shrinkWrap: true,
                                                  //     itemCount: _.tours.length,
                                                  //     scrollDirection:
                                                  //         Axis.vertical,
                                                  //     itemBuilder:
                                                  //         (context, index) {
                                                  //       return Padding(
                                                  //         padding:
                                                  //             const EdgeInsets
                                                  //                     .symmetric(
                                                  //                 horizontal: 20),
                                                  //         child: Padding(
                                                  //           padding:
                                                  //               const EdgeInsets
                                                  //                       .only(
                                                  //                   bottom: 250),
                                                  //           child: _buildTour(
                                                  //               _.tours[index]),
                                                  //         ),
                                                  //       );
                                                  //     }),
                                                  ),
                                        ))),
                              ),
                            ]))))));
  }
}
