import 'package:discoverrd/app/bindings/splash_binding.dart';
import 'package:discoverrd/app/pages/tour/tour_confirm_reserve.dart';
import 'package:discoverrd/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'app/config/app_config.dart';
import 'app/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = AppConfig.STRIPE_PUBLISHABLE_KEY;
  Stripe.merchantIdentifier = 'merchant.discoverrd.stripe.test';
  Stripe.urlScheme = 'discoverrd';
  await Stripe.instance.applySettings();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('es', 'US'),
      ],
      locale: const Locale('es', 'US'),
      title: 'discover rd',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Color(0xFF316BFF),
        fontFamily: 'Poppins',
        hintColor: Color(0xFF5A739C),
      ),
      getPages: AppPages.pages,
      // home: TourReservePage(),
      // initialBinding: TourReserveBinding(),
      home: SplashPage(),
      initialBinding: SplashBinding(),
    );
  }
}
