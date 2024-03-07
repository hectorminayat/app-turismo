import 'package:discoverrd/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 1.obs;
  final storage = GetStorage();

  setCurrentPage() {
    if(currentPage.value == 3){
      storage.write('ONBOARDING', '1');
      Get.offNamed(Routes.LOGIN);
      return;
    }
    else
      currentPage.value ++;
  }

  setSlideBackPage() {
    if(currentPage.value == 1)
      return;
    
    currentPage.value --;
  }

  setSlidePage() {
    
    if(currentPage.value == 3)
     return;
    
    else
      currentPage.value ++;
  }

}
