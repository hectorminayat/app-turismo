import 'package:discoverrd/app/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog(
      {required this.title,
      this.content: "",
      this.cancelOk: false,
      this.okText: 'OK',
      this.okColor: primaryColor,
      this.cancelText: 'Cancelar',
      this.cancelColor: Colors.red,
      this.onPressedOk,
      this.onPressedCancel})
      : super();
  final String title;
  final String content;
  final bool cancelOk;
  final Color cancelColor;
  final String okText;
  final Color okColor;
  final String cancelText;
  final VoidCallback? onPressedOk;
  final VoidCallback? onPressedCancel;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        textAlign: TextAlign.center,
      ),
      content: Text(content, textAlign: TextAlign.center, style: TextStyle()),
      actions: [
        Column(
          children: [
            Divider(
              color: Colors.black,
            ),
            cancelOk
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () => onPressedCancel == null
                              ? Get.back()
                              : onPressedCancel!(),
                          child: Text(cancelText,
                              style: TextStyle(
                                  color: cancelColor, fontSize: 16.0))),
                      TextButton(
                          onPressed: () =>
                              onPressedOk == null ? Get.back() : onPressedOk!(),
                          child: Text(okText,
                              style:
                                  TextStyle(color: okColor, fontSize: 16.0))),
                    ],
                  )
                : Center(
                    child: TextButton(
                        onPressed: () =>
                            onPressedOk == null ? Get.back() : onPressedOk!(),
                        child: Text(okText,
                            style: TextStyle(color: okColor, fontSize: 16.0)))),
          ],
        )
      ],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14.0))),
    );
  }
}
