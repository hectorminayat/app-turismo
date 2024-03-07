import 'package:discoverrd/app/config/theme_config.dart';
import 'package:discoverrd/app/controllers/tour_controller.dart';
import 'package:discoverrd/app/widgets/back_button_widget.dart';
import 'package:discoverrd/app/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterTourInclude extends StatelessWidget {
  RegisterTourInclude();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    Widget _buildChip(int id, String label, TourController controller) {
      return FilterChip(
        backgroundColor: secundaryColors1,
        labelPadding: EdgeInsets.all(2.0),
        label: Text(
          label,
          style: TextStyle(
            color: controller.includesCache.contains(id)
                ? Colors.white
                : Colors.black,
          ),
        ),
        selectedColor: primaryColor,
        selected: controller.includesCache.contains(id),
        elevation: 0.0,
        padding: EdgeInsets.all(8.0),
        onSelected: (bool selected) {
          if (selected)
            controller.includesCache.add(id);
          else
            controller.includesCache.removeWhere((int value) => value == id);
        },
      );
    }

    Widget _chipList(TourController controller, int categoryId, String title) {
      final list = controller.includeItems
          .where((element) => element.includeCategoryId == categoryId)
          .toList();
      if (list.length == 0) return Container();
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Wrap(
              spacing: 6.0,
              runSpacing: 6.0,
              children: <Widget>[
                for (var i = 0; i < list.length; i++)
                  _buildChip(list[i].id!, list[i].name!, controller)
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      );
    }

    return GetBuilder<TourController>(
        builder: (_) => WillPopScope(
              onWillPop: () async {
                _.clearInclude();
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
                              BackButtonWidget(onPressed: _.clearInclude),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(right: 64),
                                child: Text(
                                  "Incluir en la excursión",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ))
                            ],
                          )),
                          Obx(() => Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _chipList(_, 1, "Comida"),
                                  _chipList(_, 2, "Bebidas"),
                                  _chipList(_, 3, "Equipo"),
                                  _chipList(_, 4, "Entradas"),
                                ],
                              )),
                          RoundedButton(
                              title: 'Guardar',
                              padding: EdgeInsets.only(top: 10),
                              onPressed: _.saveIncludes)
                        ],
                      ),
                    )),
              )),
            ));
  }
}
