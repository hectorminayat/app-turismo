part of './app_pages.dart';

abstract class Routes {
  static const INITIAL = '/splash';
  static const SPLASH = '/splash';
  static const HOME = '/home';
  static const LOGIN = '/auth/login';
  static const REGISTER_CUSTOMER = '/auth/register/customer';
  static const REGISTER_AGENCY = '/auth/register/agency';
  static const ONBOARDING = '/onboarding';
  static const REGISTER_TOUR = '/agency/tours/register';
  static const EDIT_TOUR = '/agency/tours/edit';
  static const AGENCY_TOUR_LIST = '/agency/tours';
  static const EDIT_USER = '/user/edit';
  static const SEARCH = '/search';
  static const TOUR_DETAIL = '/tour/detail';
  static const TOUR_RESERVE = '/tour/reserve';
  static const TOUR_RESERVE_DETAIL = '/tour/reserve/detail';
}
