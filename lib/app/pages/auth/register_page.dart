import 'package:discoverrd/app/controllers/auth/register_controller.dart';
import 'package:discoverrd/app/routes/app_pages.dart';
import 'package:discoverrd/app/utils/validators/CustomMinLengthValidator.dart';
import 'package:discoverrd/app/widgets/back_button_widget.dart';
import 'package:discoverrd/app/widgets/input_flat_widget.dart';
import 'package:discoverrd/app/widgets/input_password_flat_widget.dart';
import 'package:discoverrd/app/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage() : super();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    Widget _agencyText(_){
      return Container(
        padding: EdgeInsets.only(bottom: 10.0),
        child: Center(
          child: TextButton(
            onPressed: () => _.goToPage(Routes.REGISTER_AGENCY),
            child: RichText(
              text: TextSpan(
              text: '¿Eres una agencia?, ',
              style: TextStyle(color: Colors.black, fontSize: 16),
              children: <TextSpan>[
                TextSpan(
                  text: 'Registrate como agencia',
                  style: TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.bold))
              ]),
            )
        )),
      );
    }

    Widget _loginText(_) {
      return Center(
        child: TextButton(
          onPressed: () => _.goToPage(Routes.LOGIN),
          child: RichText(
            text: TextSpan(text: '¿Ya tienes una cuenta?, ',style: TextStyle(color: Colors.black, fontSize: 16),
            children: <TextSpan>[
              TextSpan(text: 'Iniciar sesión', style: TextStyle(color: Theme.of(context).accentColor,fontWeight: FontWeight.bold)),
            ]),
            )
        ));
    }

    return GetBuilder<RegisterController>(
      builder: (_) => Scaffold(
        body: SafeArea(
          child: Container(
            height: height,
            width: width,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.0),
                    Align(alignment: Alignment.topLeft, child: BackButtonWidget()),
                    Text("Nueva \nCuenta",style:TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10.0),

                    //Name
                    InputFlatWidget(text: 'Nombre', prefixIcon: Icons.person, controller: _.nameCtrl, validator: 
                      MultiValidator([RequiredValidator(errorText: 'El nombre es requerido'), CustomMinLengthValidator(4, errorText: 'Debe tener al menos 4 letras')])),

                    //LastName
                    InputFlatWidget(text: 'Apellido', prefixIcon: Icons.person, controller: _.lastNameCtrl, validator: CustomMinLengthValidator(4, errorText: 'Debe tener al menos 4 letras')),
                    
                    //Email
                    InputFlatWidget(text: 'Correo electrónico', prefixIcon: Icons.email, keyboardType: TextInputType.emailAddress, controller: _.emailCtrl, validator: 
                      MultiValidator([ RequiredValidator(errorText: 'El correo electrónico es requerido'), EmailValidator(errorText: 'Por favor, introduce una correo electrónico válido')])),
                    
                    //Password
                    InputPasswordFlatWidget(text: 'Contraseña', controller: _.passwordCtrl),
                    
                    //Submit
                    Obx(() => RoundedButton(title: "Crear Nueva Cuenta", onPressed: () {
                      if (!formKey.currentState!.validate()) return;
                      _.submit();
                    }, loading: _.loading.value)),

                    _agencyText(_),
                    _loginText(_),
                ],),
              ),
            )),
        )
      )
    );
  }
}
