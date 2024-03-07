import 'package:discoverrd/app/models/agency_view.dart';
import 'package:discoverrd/app/models/tour_rating.dart';
import 'package:discoverrd/app/models/tour_reserve_view.dart';
import 'package:discoverrd/app/models/tour_view.dart';
import 'package:discoverrd/app/routes/app_pages.dart';
import 'package:discoverrd/app/services/auth/user_service.dart';
import 'package:discoverrd/app/services/tour_service.dart';
import 'package:discoverrd/app/widgets/custom_alert_dialog.dart';
import 'package:discoverrd/app/widgets/input_flat_widget.dart';
import 'package:discoverrd/app/widgets/rounded_button_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:flutter/material.dart';

class TourReserveDetailController extends GetxController {
  RxBool loading = false.obs;
  Rx<TourReserveView> tour = TourReserveView().obs;
  Rx<AgencyView> agency = AgencyView().obs;
  final TourService _service = Get.find<TourService>();
  final UserService _userService = Get.find<UserService>();
  RxBool finished = false.obs;
  RxBool checkRating = false.obs;
  Rx<TourRating> tourRating = TourRating().obs;

  @override
  void onInit() async {
    super.onInit();
    await Jiffy.locale("es");
    await load();
  }

  Future<void> load() async {
    try {
      loading.value = true;
      TourReserveView res = await _service.getReserveByid(Get.parameters["id"]);
      tour.value = res;

      AgencyView data = await _userService.getAgencyByPRID(res.tour!.agencyId!);
      agency.value = data;

      loading.value = false;

      final finishDate =
          res.tour!.durationType == 0 ? res.invoice!.date : res.invoice!.date2;
      finished.value = finishDate!.isBefore(DateTime.now());

      tourRating.value =
          tourRating.value.copyWith(rating: 5.0, userId: 0, id: 0);

      tourRating.value = tourRating.value.copyWith(tourId: res.tour!.id);

      print(finished.value);

      checkRating.value = await _service.checkRating(res.tour!.id!);
    } catch (e) {
      loading.value = false;
      print(e);
    }
  }

  void toReserve(TourView tour) {
    Get.toNamed('${Routes.TOUR_RESERVE}?id=${tour.tour!.id}');
  }

  void feedback() {
    ratingModal();
  }

  void setRating(double value) {
    tourRating.value = tourRating.value.copyWith(rating: value);
  }

  void onCommentChanged(String text) {
    tourRating.value = tourRating.value.copyWith(comment: text);
  }

  void submitFeedback() async {
    try {
      loading.value = false;
      print(tourRating.value.id);
      await _service.rating(tourRating.value);
      Get.back();
      Get.dialog(CustomAlertDialog(
        title: 'Exito!',
        content: 'Gracias por calificar la excursión.',
        okText: 'Aceptar',
        onPressedOk: () {
          Get.back();
        },
      ));
      await load();
    } catch (e) {
      loading.value = false;
      Get.dialog(CustomAlertDialog(
        title: 'Ha ocurrido un error',
        content: 'Tenemos problemas para procesar su solicitud.',
        okText: 'Aceptar',
      ));
    }
  }

  void ratingModal() {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("VALORA TU EXCURSION",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.close))
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text("Califica tu experiencia en la excursión"),
            )),
            Center(
              child: RatingBar.builder(
                itemSize: 50,
                initialRating: 5,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setRating(rating);
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(
                  left: 32.0,
                  right: 32,
                  bottom: MediaQuery.of(Get.context!).viewInsets.bottom),
              child: Center(
                child: InputFlatWidget(
                    minLines: 4,
                    text: 'Opinion sobre el excursión',
                    onChanged: onCommentChanged,
                    hintText:
                        'Escribe una pequeña descripcion sobre  tu experiencia en la excursión',
                    hintTitle: false),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: RoundedButton(
                  title: 'ENVIAR',
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  onPressed: () => submitFeedback()),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
