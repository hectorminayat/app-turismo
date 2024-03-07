import 'package:discoverrd/app/config/theme_config.dart';
import 'package:discoverrd/app/utils/validators/CustomMinLengthValidator.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class InputPasswordFlatWidget extends StatefulWidget {
  InputPasswordFlatWidget({
    required this.text,
    this.padding: const EdgeInsets.only(bottom: 15),
    this.onChanged, 
    this.controller
  });

  final String text;
  final EdgeInsetsGeometry padding;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  @override
  _InputPasswordFlatWidgetState createState() => _InputPasswordFlatWidgetState();
}

class _InputPasswordFlatWidgetState extends State<InputPasswordFlatWidget> {
    bool _showPassword = false;
  void _handleTap() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }
   
final passwordValidator = MultiValidator([  
    RequiredValidator(errorText: 'la contraseña es requerida'),  
    CustomMinLengthValidator(6, errorText: 'debe tener al menos 4 dígitos'),  
 ]);  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      child: TextFormField(
        onChanged: widget.onChanged,
        obscureText: !_showPassword,
        controller: widget.controller,
        validator: passwordValidator,
        decoration: InputDecoration(
          hintText: widget.text,
          prefixIcon: Icon(Icons.lock, color: Theme.of(context).accentColor),
          suffixIcon: IconButton(splashColor: Colors.transparent, highlightColor: Colors.transparent, 
            icon: Icon( _showPassword ? Icons.visibility : Icons.visibility_off, color: Color(0xFFBCCCE6)), onPressed: () => _handleTap()),
          hintStyle: TextStyle(color: secundaryColors2, fontWeight: FontWeight.w500),
          fillColor: secundaryColors1,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 1),
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
          )
        ),
      ),
    );
  }
}
