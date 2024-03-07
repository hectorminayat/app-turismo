import 'package:discoverrd/app/bindings/agency_tour_list_binding.dart';
import 'package:discoverrd/app/bindings/auth/login_binding.dart';
import 'package:discoverrd/app/bindings/auth/register_binding.dart';
import 'package:discoverrd/app/bindings/auth/register_agency_binding.dart';
import 'package:discoverrd/app/bindings/search_binding.dart';
import 'package:discoverrd/app/bindings/tour_detail_binding.dart';
import 'package:discoverrd/app/bindings/tour_reserve_binding.dart';
import 'package:discoverrd/app/bindings/tour_reserve_detail_binding.dart';
import 'package:discoverrd/app/bindings/user_binding.dart';
import 'package:discoverrd/app/bindings/home_binding.dart';
import 'package:discoverrd/app/bindings/onboarding_binding.dart';
import 'package:discoverrd/app/bindings/register_tour_binding.dart';
import 'package:discoverrd/app/bindings/splash_binding.dart';
import 'package:discoverrd/app/pages/agency/agency_tour_list_page.dart';
import 'package:discoverrd/app/pages/auth/login_page.dart';
import 'package:discoverrd/app/pages/auth/register_agency/register_agency_page.dart';
import 'package:discoverrd/app/pages/auth/register_page.dart';
import 'package:discoverrd/app/pages/home/pages/search/search_page.dart';
import 'package:discoverrd/app/pages/tour/tour_detail_page.dart';
import 'package:discoverrd/app/pages/tour/tour_reserve_detail_page.dart';
import 'package:discoverrd/app/pages/tour/tour_reserve_page.dart';
import 'package:discoverrd/app/pages/user/edit_profile_page.dart';
import 'package:discoverrd/app/pages/home/home_page.dart';
import 'package:discoverrd/app/pages/onboarding_page.dart';
import 'package:discoverrd/app/pages/form_tour/form_tour_page.dart';
import 'package:discoverrd/app/pages/splash_page.dart';
import 'package:get/get.dart';
part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: Routes.SPLASH,
        page: () => SplashPage(),
        binding: SplashBinding(),
        transition: Transition.native),
    GetPage(
        name: Routes.HOME,
        page: () => HomePage(),
        binding: HomeBinding(),
        transition: Transition.native),
    GetPage(
        name: Routes.LOGIN,
        page: () => LoginPage(),
        binding: LoginBinding(),
        transition: Transition.native),
    GetPage(
        name: Routes.REGISTER_CUSTOMER,
        page: () => RegisterPage(),
        binding: RegisterBinding(),
        transition: Transition.native),
    GetPage(
        name: Routes.REGISTER_AGENCY,
        page: () => RegisterAgencyPage(),
        binding: RegisterAgencyBinding(),
        transition: Transition.native),
    GetPage(
        name: Routes.ONBOARDING,
        page: () => OnboardingPage(),
        binding: OnboardingBinding(),
        transition: Transition.native),
    GetPage(
        name: Routes.REGISTER_TOUR,
        page: () => FormTourPage(),
        binding: RegisterTourBinding(),
        transition: Transition.native),
    GetPage(
        name: Routes.EDIT_TOUR,
        page: () => FormTourPage(),
        binding: RegisterTourBinding(),
        transition: Transition.native),
    GetPage(
        name: Routes.AGENCY_TOUR_LIST,
        page: () => AgencyTourListPage(),
        binding: AgencyTourListBinding(),
        transition: Transition.native),
    GetPage(
        name: Routes.EDIT_USER,
        page: () => EditProfilePage(),
        binding: UserBinding(),
        transition: Transition.native),
    GetPage(
        name: Routes.SEARCH,
        page: () => SearchPage(),
        binding: SearchBinding(),
        transition: Transition.native),
    GetPage(
        name: Routes.TOUR_DETAIL,
        page: () => TourDetailPage(),
        binding: TourDetailBinding(),
        transition: Transition.native),
    GetPage(
        name: Routes.TOUR_RESERVE,
        page: () => TourReservePage(),
        binding: TourReserveBinding(),
        transition: Transition.downToUp),
    GetPage(
        name: Routes.TOUR_RESERVE_DETAIL,
        page: () => TourReserveDetailPage(),
        binding: TourReserveDetailBinding(),
        transition: Transition.native),
  ];
}
