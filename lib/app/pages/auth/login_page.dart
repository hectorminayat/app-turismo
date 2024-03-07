import 'package:discoverrd/app/controllers/auth/login_controller.dart';
import 'package:discoverrd/app/widgets/auth/social_button_widget.dart';
import 'package:discoverrd/app/widgets/back_button_widget.dart';
import 'package:discoverrd/app/widgets/input_flat_widget.dart';
import 'package:discoverrd/app/widgets/input_password_flat_widget.dart';
import 'package:discoverrd/app/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage() : super();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    Widget _registerText(_) {
      return Center(
        child: TextButton(
        onPressed: () => _.goToRegisterPage(),
        child: RichText(
          text: TextSpan(
            text: '¿No tienes una cuenta?, ',
            style: TextStyle(color: Colors.black, fontSize: 16),
            children: <TextSpan>[
              TextSpan(
                text: 'Crea una cuenta',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                )
              )
            ],
          ),
        )));
    }

    return GetBuilder<LoginController>(
      builder: (_) => Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: Container(
              height: height,
              width: width,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.0),
                    Align(alignment: Alignment.topLeft, child: BackButtonWidget()),
                    Text("Iniciar \nSesión", style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    InputFlatWidget(
                      text: 'Correo electrónico',
                      prefixIcon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: _.onEmailChanged),
                    InputPasswordFlatWidget(
                      text: 'Contraseña',
                      onChanged: _.onPasswordChanged),
                      Obx(() => RoundedButton(title: "Iniciar Sesión", onPressed: _.submit, loading: _.loading.value, disabled: _.disableSubmit.value,)),
                      Center(
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "¿Olvidaste tu contraseña?",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                            )
                      )),
                      SizedBox(height: 15),
                      Center(child: Text("O inicia sesión usando",style: TextStyle(fontSize: 16))),
                      SizedBox(height: 10),
                      SocialButton(
                        label: 'Google',
                        image: 'assets/images/ui/google_logo.png',
                        textColor: Colors.black,
                        color: Colors.white,
                        onPrimary: Theme.of(context).accentColor),
                      SocialButton(
                        label: 'Facebook',
                        image: 'assets/images/ui/facebook_logo_w.png',
                        color: Color(0xFF1877F2)),
                      _registerText(_)
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
