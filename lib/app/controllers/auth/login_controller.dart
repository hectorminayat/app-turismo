import 'package:discoverrd/app/routes/app_pages.dart';
import 'package:discoverrd/app/services/auth/auth_service.dart';
import 'package:discoverrd/app/widgets/custom_alert_dialog.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  String _email = '', _password = '';

  RxBool loading = false.obs;
  RxBool disableSubmit = true.obs;

  void onEmailChanged(String text) {
    _email = text;
    _checkDisableSubmit();
  }

  void onPasswordChanged(String text) {
    _password = text;
    _checkDisableSubmit();
  }

  _checkDisableSubmit() {
    disableSubmit.value = !(_password.length > 0 && _email.length > 0);
  }

  submit() async {
    try {
      loading.value = true;
       await _authService.login(_email, _password);
      loading.value = false;
       Get.offAllNamed(Routes.HOME);
    } catch (e) {
      if (e.toString() == "InvalidPassOrUser") {
        Get.dialog(CustomAlertDialog(title: 'Email o contraseña incorrectos', 
          content: 'Parece que el email que ingresaste no pertenece a ninguna cuenta o la contraseña es incorrecta. Comprueba tu email y contraseña y vuelve a intentarlo.',
          okText: 'Intentar de nuevo'
        ));
      }
      else if(e.toString() == "Unverified") {
          Get.dialog(CustomAlertDialog(title: 'La verificación está pendiente', 
            content: 'Actualmente estamos verificando su identificación de agencia. Esto toma alrededor de 24 horas.',
            okText: 'Aceptar'
        ));
      }
      else {
        Get.dialog(CustomAlertDialog(
            title: 'Ha ocurrido un error',
            content: 'Tenemos problemas para iniciar sesión.',
            okText: 'Aceptar',
          ));
        loading.value = false;
      }
      
      loading.value = false;
    } 
  }
  goToRegisterPage() {
    Get.toNamed(Routes.REGISTER_CUSTOMER);
  }
}
