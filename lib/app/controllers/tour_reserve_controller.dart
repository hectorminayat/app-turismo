import 'package:discoverrd/app/pages/tour/tour_confirm_reserve.dart';
import 'package:discoverrd/app/widgets/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:discoverrd/app/models/invoice.dart';
import 'package:discoverrd/app/models/tour_reserve_date_view.dart';
import 'package:discoverrd/app/models/tour_view.dart';
import 'package:discoverrd/app/services/payment_service.dart';
import 'package:discoverrd/app/services/stripe_service.dart';
import 'package:discoverrd/app/services/tour_service.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class TourReserveController extends GetxController {
  RxBool loading = false.obs;
  final TourService _tourService = Get.find<TourService>();
  final StripeService _stripeService = Get.find<StripeService>();
  final PaymentService _paymentService = Get.find<PaymentService>();
  Rx<TourView> tour = TourView().obs;
  final RxList<TourReserveDateView> tourReserveDates =
      RxList<TourReserveDateView>();
  final Rx<Invoice> invoice = Invoice(id: 0, adults: 1, kids: 0, amount: 0).obs;
  RxDouble adultPrice = 0.0.obs;
  RxDouble kidPrice = 0.0.obs;
  RxBool isKid = false.obs;
  RxString selectedDate = 'N/A'.obs;

  @override
  void onInit() async {
    super.onInit();
    await Jiffy.locale("es");
    await loadTour();
  }

  Future<void> loadTour() async {
    loading.value = true;
    TourView res = await _tourService.getByid(Get.parameters["id"]);
    tour.value = res;

    invoice.value = invoice.value.copyWith(tourId: res.tour!.id!);

    adultPrice.value = res.tour!.adultPrice ?? 0;
    kidPrice.value = res.tour!.kidPrice ?? 0;
    isKid.value = res.tour!.enableKidPrice ?? false;

    if (res.tour!.durationType == 0) {
      final dates = res.tour!.tourDates!;
      dates.sort((b, a) => a.date!.compareTo(b.date!));

      for (var date in dates) {
        tourReserveDates.add(TourReserveDateView(
            id: date.id, date: date.date, text: Jiffy(date.date).yMMMMd));
      }
    }

    if (res.tour!.durationType == 1) {
      final dates = res.tour!.tourDatesRages!;
      dates.sort((b, a) => a.startDate!.compareTo(b.startDate!));

      for (var date in dates) {
        tourReserveDates.add(TourReserveDateView(
            id: date.id,
            date: date.startDate,
            date2: date.endDate,
            text:
                "${Jiffy(date.startDate).yMMMMd} - ${Jiffy(date.endDate).yMMMMd}"));
      }
    }
    loading.value = false;
  }

  setDate(TourReserveDateView tourReserveDateView) {
    invoice.value = invoice.value.copyWith(
        date: tourReserveDateView.date, date2: tourReserveDateView.date2);
    selectedDate.value = tourReserveDateView.text!;
  }

  changeAdult(int value) {
    invoice.value = invoice.value.copyWith(adults: value);
  }

  changeKid(int value) {
    invoice.value = invoice.value.copyWith(kids: value);
  }

  double calculateAmount() {
    double fee = 100.00;
    double total = (adultPrice.value * invoice.value.adults!) + fee;
    if (isKid.value) {
      total = total + (kidPrice.value * invoice.value.kids!);
    }
    return total;
  }

  Future<void> _initPaymentSheet(double amount) async {
    final data = await _stripeService.paymentSheet(amount);
    invoice.value =
        invoice.value.copyWith(paymentIntent: data['paymentIntent']);

    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        // Main params
        paymentIntentClientSecret: data['paymentIntent'],
        merchantDisplayName: 'Discoverrd tour reserve',
        // Customer params
        customerId: data['customer'],
        customerEphemeralKeySecret: data['ephemeralKey'],
        // Extra params
        applePay: true,
        googlePay: true,
        testEnv: true,
        merchantCountryCode: 'DO',
      ),
    );
  }

  void payment() async {
    try {
      Get.dialog(Center(child: CircularProgressIndicator()),
          barrierDismissible: false);
      double amount = calculateAmount();
      invoice.value = invoice.value.copyWith(amount: amount);
      await _initPaymentSheet(amount);
      Get.back();
      await Stripe.instance.presentPaymentSheet();
      Get.dialog(Center(child: CircularProgressIndicator()),
          barrierDismissible: false);
      await _paymentService.createInvoice(invoice.value);
      Get.back();
      Get.offAll(TourConfirmReserve());
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        return;
      }
      Get.back();
      Get.dialog(CustomAlertDialog(
        title: 'Ha ocurrido un error',
        content: 'Tenemos problemas para procesar su solicitud.',
        okText: 'Aceptar',
      ));
    } catch (e) {
      Get.back();
      Get.dialog(CustomAlertDialog(
        title: 'Ha ocurrido un error',
        content: 'Tenemos problemas para procesar su solicitud.',
        okText: 'Aceptar',
      ));
    }
  }
}
