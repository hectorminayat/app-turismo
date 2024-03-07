import 'dart:ui';

import 'package:discoverrd/app/routes/app_pages.dart';
import 'package:discoverrd/app/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TourConfirmReserve extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Widget svgImage = Image.asset(
      'assets/images/success.png',
      width: Get.width * 0.7,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          width: Get.width,
          height: Get.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                svgImage,
                Padding(
                  padding: EdgeInsets.only(top: 40.0),
                  child: Text('Confirmado',
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.black,
                          letterSpacing: 0.6,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  width: Get.width * 0.7,
                  margin: EdgeInsets.only(top: 10, bottom: 50),
                  child: Text(
                    'Recibirás un correo electrónico junto con la confirmación de tu reserva.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Color(0xFF7B7E82)),
                  ),
                ),
                Container(
                    width: Get.width * 0.4,
                    child: RoundedButton(
                      title: "Volver al inicio",
                      fontSize: 13,
                      onPressed: () {
                        Get.offAllNamed(Routes.HOME);
                      },
                    ))
              ],
            ),
          )),
    );
  }
}
