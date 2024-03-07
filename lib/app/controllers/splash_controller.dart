import 'package:discoverrd/app/routes/app_pages.dart';
import 'package:discoverrd/app/services/auth/token_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  final TokenService _tokenService = Get.find<TokenService>();
  final storage = GetStorage();

  @override
  void onReady() {
    super.onReady();
    _init();
  }

  _init() async {
    await Future.delayed(Duration(milliseconds: 1400));
    final String? onboarding = storage.read('ONBOARDING');
    if(onboarding != null && onboarding == '1'){
      final String? token = _tokenService.getToken();
      Get.offNamed(token != null ? Routes.HOME : Routes.LOGIN);
    }
    else {
      Get.offNamed(Routes.ONBOARDING);
    }
  
  }
}
