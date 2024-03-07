import 'package:discoverrd/app/controllers/search_controller.dart';
import 'package:discoverrd/app/widgets/back_button_widget.dart';
import 'package:discoverrd/app/widgets/input_flat_widget.dart';
import 'package:discoverrd/app/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPrice extends StatelessWidget {
  SearchPrice();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GetBuilder<SearchController>(
        builder: (_) => Scaffold(
                body: SafeArea(
              child: Container(
                  height: height,
                  width: width,
                  padding:
                      EdgeInsets.only(top: 10, bottom: 0, left: 15, right: 15),
                  child: SingleChildScrollView(
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
                                "Elige el precio",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ))
                          ],
                        )),
                        SizedBox(height: 10),
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InputFlatWidget(
                                width: Get.width * 0.44,
                                text: 'Min',
                                controller: _.minPricePRCtrl,
                                hintTitle: false,
                                keyboardType: TextInputType.number,
                              ),
                              InputFlatWidget(
                                width: Get.width * 0.44,
                                text: 'Max',
                                controller: _.maxPricePRCtrl,
                                hintTitle: false,
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        RoundedButton(
                            title: 'Aceptar',
                            padding: EdgeInsets.only(top: 40),
                            onPressed: _.savePrice)
                      ],
                    ),
                  )),
            )));
  }
}
