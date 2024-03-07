import 'package:discoverrd/app/config/app_config.dart';
import 'package:discoverrd/app/config/theme_config.dart';
import 'package:discoverrd/app/controllers/home_controller.dart';
import 'package:discoverrd/app/models/tour_view.dart';
import 'package:discoverrd/app/widgets/like_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({required this.controller});
  final HomeController controller;
  Widget _buildTour(TourView tour) {
    return InkWell(
      onTap: () {
        controller.toDetail(tour);
      },
      child: Center(
        child: Container(
          width: Get.width - 32,
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
                width: Get.width - 32,
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
    return Scaffold(
        body: SafeArea(
            child: Container(
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
                        "Mis Destinos",
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
                                  () => controller.likesTours.length == 0
                                      ? Container()
                                      : SingleChildScrollView(
                                          child: Column(
                                          children: [
                                            for (var item
                                                in controller.likesTours)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 20),
                                                  child: _buildTour(item),
                                                ),
                                              )
                                          ],
                                        )),
                                ))),
                      ),
                    ]))));
  }
}
