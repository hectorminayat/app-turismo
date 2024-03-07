import 'package:discoverrd/app/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({this.onPressed});
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed ?? () => Get.back(),
      child: Icon(Icons.arrow_back, color: Theme.of(context).accentColor),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.all(12)),
          elevation: MaterialStateProperty.all(0.0),
          shape: MaterialStateProperty.all(CircleBorder()),
          backgroundColor: MaterialStateProperty.all(secundaryColors1),
          overlayColor:  MaterialStateProperty.all(primaryColor.withOpacity(0.2)), 
        ),
    );
  }
}
