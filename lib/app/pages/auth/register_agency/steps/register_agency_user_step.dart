import 'package:discoverrd/app/config/theme_config.dart';
import 'package:discoverrd/app/controllers/auth/register_agency_controller.dart';
import 'package:discoverrd/app/utils/validators/CustomMinLengthValidator.dart';
import 'package:discoverrd/app/widgets/back_button_widget.dart';
import 'package:discoverrd/app/widgets/input_flat_widget.dart';
import 'package:discoverrd/app/widgets/input_password_flat_widget.dart';
import 'package:discoverrd/app/widgets/rounded_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class RegisterAgencyUserStep extends StatelessWidget {
  const RegisterAgencyUserStep({required this.controller, this.onPressedCreateBtn, this.formkey, this.registerTextOnPressed, this.loginTextOnPressed});
  
  final VoidCallback? onPressedCreateBtn;
  final RegisterAgencyController controller;
  final Key? formkey;
  final VoidCallback? registerTextOnPressed;
  final VoidCallback? loginTextOnPressed;


  Widget _resgisterText() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Center(
        child: TextButton(
          onPressed: registerTextOnPressed,
          child: RichText(
            text: TextSpan( text: '¿No eres una agencia?, ', style: TextStyle(color: Colors.black, fontSize: 16),
            children: <TextSpan>[
              TextSpan(text: 'Volver', style: TextStyle( color: primaryColor, fontWeight: FontWeight.bold)),
            ])
          )
        )),
    );
  }

  Widget _loginText() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Center(
        child: TextButton(
          onPressed: loginTextOnPressed,
          child: RichText(
            text: TextSpan( text: '¿¿Ya tienes una cuenta?, ', style: TextStyle(color: Colors.black, fontSize: 16),
            children: <TextSpan>[
              TextSpan(text: 'Iniciar sesión', style: TextStyle( color: primaryColor, fontWeight: FontWeight.bold)),
            ])
          )
        )),
    );
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
            SizedBox(height: 10.0),
            Align(
              alignment: Alignment.topLeft,
              child: BackButtonWidget(),
            ),
            Text(
              "Nueva Cuenta \nAgencia",
              style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Form(
              key: formkey,
              child: Column(
                children: [
                  //Name
                  InputFlatWidget(text: 'Nombre', prefixIcon: Icons.person, controller: controller.nameCtrl,validator: 
                    MultiValidator([RequiredValidator(errorText: 'El nombre es requerido'), CustomMinLengthValidator(4, errorText: 'Debe tener al menos 4 letras')])),
                  
                  //RNC
                  InputFlatWidget(text: 'RNC', prefixIcon: Icons.badge, controller: controller.rncCtrl,validator: 
                    MultiValidator([RequiredValidator(errorText: 'El RNC es requerido'), CustomMinLengthValidator(4, errorText: 'Debe tener al menos 4 letras')])),
                  
                  //Email
                  InputFlatWidget(text: 'Correo electrónico', prefixIcon: Icons.email, 
                    keyboardType: TextInputType.emailAddress, controller: controller.emailCtrl, validator: 
                      MultiValidator([ RequiredValidator(errorText: 'El correo electrónico es requerido'), 
                        EmailValidator(errorText: 'Por favor, introduce una correo electrónico válido')])),

                  InputPasswordFlatWidget(text: 'Contraseña', controller: controller.passwordCtrl),
                  Obx(() => RoundedButton(title: "Crear Nueva Cuenta", onPressed: onPressedCreateBtn, loading: controller.loading.value))
                ]
              )
            ),
           
            SizedBox(height: 10.0),
            _resgisterText(),
            _loginText(),
          ],
        ),
      ),
    );
  }
}
