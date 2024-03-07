import 'package:discoverrd/app/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dropdown<T> extends StatelessWidget {

  Dropdown({
    required this.title,
    required this.items,
    this.padding: const EdgeInsets.only(bottom: 10),
    this.prefixIcon,
    this.onChanged, 
    this.hintText, 
    this.initialValue, 
    this.helpText, 
    this.value
  });

  final String title;
  final Map<T, String> items;
  final String? hintText;
  final String? initialValue;
  final String? helpText;
  final EdgeInsetsGeometry padding;
  final IconData? prefixIcon;
  final T? value;
  final ValueChanged<T?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 2, left: 6),
            child: Text(title, style: TextStyle(fontSize: 18),),
          ),

          helpText == null ? Container() : Padding(
            padding: const EdgeInsets.only(bottom: 4, left: 6),
            child: Text(helpText!, style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.5))),
          ),
          Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(vertical: 4
            ),
            decoration: BoxDecoration(
              color: secundaryColors1,
              borderRadius: BorderRadius.circular(20)
            ),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<T>(
                  icon: Icon(Icons.expand_more, size: 32,),
                  elevation: 1,
                  value: value,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  iconEnabledColor:Colors.black,
                items: items.map((key, value) => MapEntry(value, DropdownMenuItem<T>(value: key, child: Text(value)))).values.toList(),
                onChanged: onChanged,
              ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}