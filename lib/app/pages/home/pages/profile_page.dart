import 'package:discoverrd/app/config/app_config.dart';
import 'package:discoverrd/app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({required this.controller, required this.type});
  final HomeController controller;
  final String type;

  Widget _menuItem(IconData icon, String title, VoidCallback? onPressed,
      {Color? color}) {
    if (color == null) {
      color = Color(0xFF5A739C);
    }
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            width: Get.width,
            height: Get.height * 0.08,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(children: [
              Icon(icon, size: 28, color: color),
              SizedBox(
                width: 12,
              ),
              Text(
                title,
                style: TextStyle(color: color, fontSize: 16),
              )
            ]),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          height: Get.height,
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.0),
                Center(
                  child: Obx(
                    () => Container(
                        width: 120,
                        height: 120,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: controller.imageProfile.value == ""
                                    ? Image.asset(
                                        'assets/images/notfound.png',
                                        fit: BoxFit.cover,
                                      ).image
                                    : NetworkImage(
                                        "${AppConfig.API_URL}/file/${controller.imageProfile}")))),
                  ),
                ),
                SizedBox(height: 15.0),
                Center(
                  child: Obx(
                    () => Text(
                      controller.name.value,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 2.0),
                Center(
                  child: Obx(
                    () => Text(
                      controller.email.value,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF969696)),
                    ),
                  ),
                ),
                SizedBox(height: 40.0),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _menuItem(Icons.edit, "Editar perfil",
                          () => controller.goToEditProfile(type)),
                      _menuItem(Icons.notifications, "Notificaciones", () {}),
                      _menuItem(Icons.settings, "Configuracion", () {}),
                      _menuItem(Icons.info, "Acerca de", () {}),
                      Divider(),
                      _menuItem(Icons.logout, "Cerrar sesión",
                          () => controller.logout(),
                          color: Colors.red),
                    ],
                  ),
                ),
                SizedBox(height: 40.0),
              ],
            ),
          )),
    );
  }
  // return Container(
  //   child: Center(child: Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Obx(() => Text( (controller.userInfo.length > 0) ? controller.userInfo["unique_name"] : "", style: TextStyle(fontSize: 28),)),
  //       SizedBox(height: 20,),
  //       ElevatedButton(onPressed: () => controller.logout(), child: Text("Cerrar Sesión")),
  //     ],
  //     )),
  // );
}
