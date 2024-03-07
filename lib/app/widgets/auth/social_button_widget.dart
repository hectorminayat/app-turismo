import 'package:discoverrd/app/config/theme_config.dart';
import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    required this.label, 
    required this.color, 
    required this.image, 
    this.textColor: Colors.white, 
    this.size: 25.0, 
    this.onPrimary: 
    Colors.white }) : super();

  final String label;
  final Color color;
  final String image;
  final Color textColor;
  final double size;
  final Color onPrimary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 15.0),
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Image(width: size, height: size, image: AssetImage(image)),
        label: Text(label, style: TextStyle(color: textColor)),
        // style: ElevatedButton.styleFrom(
        //   elevation: 0.0,
        //   primary: color,
        //   onPrimary: onPrimary,
        //   shadowColor: color == Colors.white ? Colors.grey[300] : color,
        //   minimumSize: Size(double.infinity, 50),
        //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        //   textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),

        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0.0),
         // elevation: disabled ? MaterialStateProperty.all(0.0)  : loading ?  MaterialStateProperty.all(0.0) : MaterialStateProperty.all(6.0),
          minimumSize: MaterialStateProperty.all(Size(double.infinity, 50)),
          overlayColor: color == Colors.white ? MaterialStateProperty.all(primaryColor.withOpacity(0.2)) : MaterialStateProperty.all(Colors.white.withOpacity(0.2)), 
          shape: MaterialStateProperty.all( RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
         // shadowColor:  MaterialStateProperty.all(Theme.of(context).accentColor),
          backgroundColor: MaterialStateProperty.all(color),
          side: color ==Colors.white ? MaterialStateProperty.all(BorderSide(width: 1, color: Colors.grey.shade400  )) : null
          //     backgroundColor: MaterialStateProperty.resolveWith<Color>(
          // // background color    this is color:
          // (Set<MaterialState> states) =>
          //     states.contains(MaterialState.disabled) ? disbleColor : Theme.of(context).accentColor,
          // ),
        ),
      )
    );
  }
}