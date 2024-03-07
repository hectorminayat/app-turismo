import 'package:discoverrd/app/config/theme_config.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({required this.title, this.onPressed, this.padding, this.loading = false, this.disabled = false, this.fontSize});

  final String title;
  final VoidCallback? onPressed;
  final EdgeInsets? padding;
  final bool loading;
  final bool disabled;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0.0),
         // elevation: disabled ? MaterialStateProperty.all(0.0)  : loading ?  MaterialStateProperty.all(0.0) : MaterialStateProperty.all(6.0),
          minimumSize: MaterialStateProperty.all(Size(double.infinity, 50)),
          shape: MaterialStateProperty.all( RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
          shadowColor:  MaterialStateProperty.all(Theme.of(context).accentColor),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
          // background color    this is color:
          (Set<MaterialState> states) =>
              states.contains(MaterialState.disabled) ? disbleColor : Theme.of(context).accentColor,
          ),
        ),
        onPressed: !disabled ? !loading ? onPressed : null : null,
        child: !loading ? Text(title, style: TextStyle(fontWeight: FontWeight.w500, fontSize: fontSize ?? 16, color: disabled ? textDisbleColor : Colors.white),) : CircularProgressIndicator(color: Colors.white)
    ));
  }
}
