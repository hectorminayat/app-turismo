import 'package:discoverrd/app/config/theme_config.dart';
import 'package:discoverrd/app/controllers/auth/register_agency_controller.dart';
import 'package:discoverrd/app/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterAgencyVerifyLicenseMsgStep extends StatelessWidget {
  const RegisterAgencyVerifyLicenseMsgStep({required this.controller, this.onPressedOkBtn});

  final RegisterAgencyController controller;
    final VoidCallback? onPressedOkBtn;

  Widget _pageInfo() {
    return Container(
        child: Column(children: [
      Align(
        alignment: Alignment.center,
        child: Container(
          width: 160,
          height: 160,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: secundaryColors1,
            borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Stack(
              children: [
                Icon(Icons.badge, size: 120, color: primaryColor),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 50,
                    height: 50,
                    child: Icon(Icons.hourglass_top, size: 22, color: primaryColor),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white)
                  )
                )
              ]
            ))
      ),
      SizedBox(height: 10.0),
      Center(child: Text("La verificación está \npendiente",
        style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)),
      Container(padding: EdgeInsets.symmetric(vertical: 18.0),
        child: Text("Actualmente estamos verificando su identificación de agencia. Esto toma alrededor de 24 horas.",
          textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0))),
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25.0),
            _pageInfo(),
            SizedBox(height: 15),
            Obx(() => RoundedButton(
              title: "Aceptar",
              onPressed: onPressedOkBtn,
              loading: controller.loading.value)),
          ]),
    ));
  }
}
