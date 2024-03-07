import 'package:discoverrd/app/config/app_config.dart';
import 'package:discoverrd/app/config/theme_config.dart';
import 'package:discoverrd/app/controllers/agency_tour_list_controller.dart';
import 'package:discoverrd/app/models/tour.dart';
import 'package:discoverrd/app/models/tour_view.dart';
import 'package:discoverrd/app/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AgencyTourListPage extends StatelessWidget {
  AgencyTourListPage();

  _buildItem(TourView tour, AgencyTourListController ctrl) {
    Tour t = tour.tour!;
    var itemHeight = Get.height / 4.5;
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Container(
        width: Get.width,
        height: itemHeight,
        padding: EdgeInsets.only(right: 12, left: 12, top: 10, bottom: 0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: itemHeight * 0.6,
                  width: (Get.width - 12) * 0.3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    // child: Image.asset(
                    //   'assets/images/notfound.png',
                    //   fit: BoxFit.cover,
                    // ),
                    child: tour.images!.length == 0
                        ? Image.asset(
                            'assets/images/notfound.png',
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            '${AppConfig.API_URL}/file/${tour.images![0]}',
                            fit: BoxFit.cover),
                  ),
                ),
                Container(width: 8),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: t.tourStatusId == 1
                                    ? Colors.green
                                    : Colors.blue),
                            borderRadius: BorderRadius.circular(
                                4) // use instead of BorderRadius.all(Radius.circular(20))
                            ),
                        child: Text(
                          t.tourStatusId == 1 ? 'Publicado' : "Sin publicar",
                          style: TextStyle(
                              color: t.tourStatusId == 1
                                  ? Colors.green
                                  : Colors.blue,
                              fontSize: 8),
                        ),
                      ),
                      Container(height: 4),
                      Container(
                        width: (Get.width - 12) * 0.45,
                        child: Text(t.title!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13)),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.place,
                              size: 18,
                            ),
                            Container(
                              width: (Get.width - 12) * 0.48,
                              child: Text(t.location!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: (Get.width - 12) * 0.45,
                        child: Text(
                          t.description!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 9, fontWeight: FontWeight.w200),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: itemHeight * 0.04,
            ),
            Container(
              width: (Get.width - 12),
              height: 0.6,
              color: Colors.grey[200],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () => ctrl.goToEdit(t.id!),
                  child: const Text('Editar',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                          fontSize: 12)),
                ),
                Container(
                  width: 18,
                ),
                TextButton(
                  onPressed: () => ctrl.delete(t.id!),
                  child: const Text('Eliminar',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                          fontSize: 12)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final Widget illustration1 = SvgPicture.asset(
      'assets/images/illustrations/illustration_1.svg',
      semanticsLabel: 'illustration 1',
      // fit: BoxFit.cover,
    );
    return GetBuilder<AgencyTourListController>(
        builder: (_) => Scaffold(
            backgroundColor: Color(0xFFf2f3f7),
            body: Obx(() => _.loading.value
                ? Container()
                : SafeArea(
                    child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: width,
                      child: Obx(() => Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 15),
                                  child: Text(
                                    "Tus Excursiones",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28),
                                  ),
                                ),
                                _.tours.length == 0
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(height: height * 0.04),
                                          Text(
                                              "Aun no has creado tu primera excursion.",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: secundaryColors2)),
                                          Container(
                                              height: height * 0.4,
                                              child: illustration1),
                                          Container(height: height * 0.02),
                                          RoundedButton(
                                              title: 'Nueva excursion',
                                              padding: EdgeInsets.only(top: 40),
                                              onPressed: _.goToRegister)
                                        ],
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                            for (var i = 0;
                                                i < _.tours.length;
                                                i++)
                                              //     Container()
                                              _buildItem(_.tours[i], _)
                                          ])
                              ])),
                    ),
                  )))));
  }
}
