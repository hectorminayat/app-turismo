import 'package:discoverrd/app/controllers/auth/register_agency_controller.dart';
import 'package:discoverrd/app/pages/auth/register_agency/steps/register_agency_info_step.dart';
import 'package:discoverrd/app/pages/auth/register_agency/steps/register_agency_user_step.dart';
import 'package:discoverrd/app/pages/auth/register_agency/steps/register_agency_verify_license_msg_step.dart';
import 'package:discoverrd/app/pages/auth/register_agency/steps/register_agency_verify_license_step.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterAgencyPage extends StatelessWidget {
  RegisterAgencyPage() : super();
  final formKeyStep1 = GlobalKey<FormState>();
  final formKeyStep2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GetBuilder<RegisterAgencyController>(
      builder: (_) => Scaffold(
        body: SafeArea(
          child: Container(
            height: height,
            width: width,
            child: PageView(
              controller: _.pageController,
              physics:new NeverScrollableScrollPhysics(),
              children: [
                RegisterAgencyUserStep(formkey: formKeyStep1, controller: _, onPressedCreateBtn: () {
                   if (!formKeyStep1.currentState!.validate()) return; 
                  _.checkUser();
                } , registerTextOnPressed: _.goToRegisterPage, loginTextOnPressed: _.goToLoginPage,),

                RegisterAgencyInfoStep(
                  controller: _,
                  formkey: formKeyStep2,
                  onPressedBackBtn: () => _.pageController.previousPage(duration: Duration(milliseconds: 400), curve: Curves.easeInOut),
                  onPressedContBtn: () { 
                    if (!formKeyStep2.currentState!.validate()) return; 
                    _.pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.easeIn);
                  },
                  onChangedImage:(img) {
                    _.setImage(img);
                  }
                ),

                RegisterAgencyVerifyLicenseStep(
                  controller: _,
                  onPressedBackBtn: () => _.pageController.previousPage(duration: Duration(milliseconds: 400), curve: Curves.easeInOut),
                  onPressedContBtn: _.submit,
                  onChangedDocument:(doc) {
                    _.setDocument(doc); 
                  },
                ),
                RegisterAgencyVerifyLicenseMsgStep(controller: _, onPressedOkBtn: _.goToLogin)
              ]
            )),
        ),
      ),
    );
  }
}
