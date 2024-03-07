import 'package:discoverrd/app/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  const SplashPage() : super();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GetBuilder<SplashController>(
      builder: (_) => Scaffold(
        body: Center(child: Image(width: width * 0.6, height: double.infinity, image: AssetImage('assets/images/discover_rd_logo.png')))
      ));
  }
}
