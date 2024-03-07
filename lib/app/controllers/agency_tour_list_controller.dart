import 'package:discoverrd/app/models/tour_view.dart';
import 'package:discoverrd/app/routes/app_pages.dart';
import 'package:discoverrd/app/services/tour_service.dart';
import 'package:discoverrd/app/widgets/custom_alert_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AgencyTourListController extends GetxController {
  final TourService _service = Get.find<TourService>();
  final RxList<TourView> tours = RxList<TourView>();

  final RxBool loading = true.obs;
  @override
  void onReady() async {
    super.onReady();
    await _getList();
  }

  _getList() async {
    try {
      loading.value = true;
      Get.dialog(Center(child: CircularProgressIndicator()),
          barrierDismissible: false);
      var result = await _service.getAllAgency();
      tours.value = List.from(result);
      loading.value = false;
      Get.back();
    } catch (e) {
      Get.back();
    }
  }

  goToRegister() {
    Get.toNamed(Routes.REGISTER_TOUR);
  }

  goToEdit(int id) {
    Get.toNamed('${Routes.EDIT_TOUR}?id=$id');
  }

  delete(int id) async {
    Get.dialog(CustomAlertDialog(
      title: 'Eliminar excursión',
      content:
          '¿Estas seguro que deseas eliminar la excursión?, No podras recuperar la excursión eliminada',
      okText: 'Eliminar',
      cancelOk: true,
      okColor: Colors.red,
      cancelColor: Colors.grey,
      onPressedOk: () async {
        await _service.delete(id);
        Get.back();
        Get.dialog(CustomAlertDialog(
          title: 'Excursión Eliminada!',
          content: 'La excursión se ha eliminado correctamente.',
          okText: 'Aceptar',
          onPressedOk: () async {
            Get.back();
            await _getList();
          },
        ));
      },
    ));
  }
}
