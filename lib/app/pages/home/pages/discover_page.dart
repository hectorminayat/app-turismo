import 'package:discoverrd/app/config/app_config.dart';
import 'package:discoverrd/app/config/theme_config.dart';
import 'package:discoverrd/app/controllers/home_controller.dart';
import 'package:discoverrd/app/models/agency_view.dart';
import 'package:discoverrd/app/models/tour_view.dart';
import 'package:discoverrd/app/widgets/like_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiscoverPage extends StatelessWidget {
  DiscoverPage({required this.controller});
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    Widget _popularTour(TourView tour) {
      return InkWell(
        onTap: () {
          controller.toDetail(tour);
        },
        child: Container(
          width: 220,
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
                width: 220,
                height: Get.height * 0.18,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Hero(
                        tag: 'tag_${tour.tour!.id}',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            '${AppConfig.API_URL}/file/${tour.images![0]}',
                            fit: BoxFit.cover,
                          ),
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
                  maxLines: 1,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              Container(
                width: (Get.width * 0.55) - 15,
                child: Row(
                  children: [
                    Icon(
                      Icons.place,
                      size: 16,
                      color: secundaryColors2,
                    ),
                    Container(
                      width: ((Get.width * 0.55) - 15) * 0.58,
                      child: Text(
                        tour.tour!.location ?? 'N/A',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(fontSize: 9, color: secundaryColors2),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 22,
                        ),
                        Text((tour.tour!.rating ?? 0).toString(),
                            style: TextStyle(
                                fontSize: 12,
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
      );
    }

    Widget _popularAgency(AgencyView agency) {
      return GestureDetector(
        onTap: () {},
        child: Container(
          width: Get.width * 0.68,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network(
                          '${AppConfig.API_URL}/file/${agency.image}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: (Get.width * 0.68) * 0.5,
                    child: Text(
                      agency.name ?? "N/A",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 32,
                      ),
                      SizedBox(width: 4),
                      Text('4.6',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return SafeArea(
      child: Container(
          height: Get.height,
          width: Get.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: Get.width * 0.45,
                          child: Image(
                            image: AssetImage(
                                'assets/images/discover_rd_logo.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                        Row(children: [
                          Container(
                            padding: EdgeInsets.all(14),
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: Icon(
                              Icons.chat_bubble,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(14),
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: Icon(
                              Icons.notifications,
                              color: primaryColor,
                            ),
                          )
                        ])
                      ]),
                ),
                SizedBox(height: 14.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text("¿A dónde \nquieres ir?",
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 8.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
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
                        onTap: controller.goToSearch,
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
                                style: TextStyle(color: secundaryColors2),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Eventos populares",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      TextButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Text(
                                "Ver mas",
                                style: TextStyle(
                                    color: primaryColor, fontSize: 14),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: primaryColor,
                              )
                            ],
                          ))
                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                    width: Get.width,
                    height: Get.height * 0.3,
                    child: Obx(
                      () => controller.popularTours.length == 0
                          ? Container()
                          : ListView.builder(
                              itemCount: controller.popularTours.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return index == 0
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            right: 20, left: 15),
                                        child: _popularTour(
                                            controller.popularTours[index]),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            right: 20, left: 0),
                                        child: _popularTour(
                                            controller.popularTours[index]),
                                      );
                              }),
                    )),
                SizedBox(height: 8.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Agencias populares",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      TextButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Text(
                                "Ver mas",
                                style: TextStyle(
                                    color: primaryColor, fontSize: 14),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: primaryColor,
                              )
                            ],
                          ))
                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                    width: Get.width,
                    height: Get.height * 0.12,
                    child: Obx(
                      () => controller.popularAgency.length == 0
                          ? Container()
                          : ListView.builder(
                              itemCount: controller.popularAgency.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return index == 0
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            right: 20, left: 15),
                                        child: _popularAgency(
                                            controller.popularAgency[index]),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            right: 20, left: 0),
                                        child: _popularAgency(
                                            controller.popularAgency[index]),
                                      );
                              }),
                    )),
              ],
            ),
          )),
    );
  }
}
