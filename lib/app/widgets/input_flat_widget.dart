import 'package:discoverrd/app/config/theme_config.dart';
import 'package:flutter/material.dart';

class InputFlatWidget extends StatelessWidget {
  InputFlatWidget(
      {required this.text,
      this.keyboardType: TextInputType.text,
      this.padding: const EdgeInsets.only(bottom: 10),
      this.prefixIcon,
      this.onChanged,
      this.controller,
      this.validator,
      this.hintTitle: true,
      this.hintText,
      this.initialValue,
      this.minLines,
      this.helpText,
      this.errorText,
      this.width,
      this.enable: true});

  final String text;
  final String? hintText;
  final String? initialValue;
  final String? helpText;
  final TextInputType keyboardType;
  final EdgeInsetsGeometry padding;
  final IconData? prefixIcon;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final bool hintTitle;
  final bool enable;
  final int? minLines;
  final String? errorText;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final cxwidth = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          hintTitle
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(bottom: 2, left: 6),
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
          helpText == null
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(bottom: 4, left: 6),
                  child: Text(helpText!,
                      style: TextStyle(
                          fontSize: 14, color: Colors.black.withOpacity(0.5))),
                ),
          TextFormField(
            enabled: this.enable,
            onChanged: onChanged,
            keyboardType: keyboardType,
            controller: controller,
            validator: validator,
            maxLines: null,
            minLines: minLines,
            initialValue: initialValue,
            decoration: InputDecoration(
                errorText: (errorText ?? '') == '' ? null : errorText,
                hintMaxLines: minLines,
                hintText: hintTitle ? text : hintText ?? null,
                prefixIcon: prefixIcon != null
                    ? Icon(prefixIcon, color: Theme.of(context).accentColor)
                    : null,
                hintStyle: TextStyle(
                    color: hintTitle
                        ? secundaryColors2
                        : secundaryColors2.withOpacity(0.6),
                    fontWeight:
                        hintTitle ? FontWeight.w500 : FontWeight.normal),
                fillColor: secundaryColors1,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 1),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: secundaryColors1, width: 1),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: secundaryColors1, width: 1),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.circular(20.0),
                )),
          ),
        ],
      ),
    );
  }
}
