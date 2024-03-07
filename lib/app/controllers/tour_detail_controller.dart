import 'package:discoverrd/app/config/app_config.dart';
import 'package:discoverrd/app/models/agency_view.dart';
import 'package:discoverrd/app/models/gallery_item.dart';
import 'package:discoverrd/app/models/include_item.dart';
import 'package:discoverrd/app/models/tour.dart';
import 'package:discoverrd/app/models/tour_view.dart';
import 'package:discoverrd/app/routes/app_pages.dart';
import 'package:discoverrd/app/services/auth/user_service.dart';
import 'package:discoverrd/app/services/tour_service.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class TourDetailController extends GetxController {
  List<IncludeItem> includeItems = [
    IncludeItem(id: 1, name: 'Refrigerios', includeCategoryId: 1),
    IncludeItem(id: 2, name: 'Almuerzo', includeCategoryId: 1),
    IncludeItem(id: 3, name: 'Desayuno', includeCategoryId: 1),
    IncludeItem(id: 4, name: 'Cena', includeCategoryId: 1),
    IncludeItem(id: 5, name: 'Postre', includeCategoryId: 1),
    IncludeItem(id: 6, name: 'Merienda', includeCategoryId: 1),
    IncludeItem(id: 7, name: 'Aperitivos', includeCategoryId: 1),
    IncludeItem(id: 8, name: 'Cerviza', includeCategoryId: 2),
    IncludeItem(id: 9, name: 'Agua', includeCategoryId: 2),
    IncludeItem(id: 10, name: 'Jugo', includeCategoryId: 2),
    IncludeItem(id: 11, name: 'Refrescos', includeCategoryId: 2),
    IncludeItem(id: 12, name: 'Equipo deportivo', includeCategoryId: 3),
    IncludeItem(id: 13, name: 'Equipo para exteriores', includeCategoryId: 3),
    IncludeItem(id: 14, name: 'Equipo de seguridad', includeCategoryId: 3),
    IncludeItem(id: 15, name: 'Materiales', includeCategoryId: 3),
    IncludeItem(id: 16, name: 'Cámara', includeCategoryId: 3),
    IncludeItem(id: 17, name: 'Fotografía', includeCategoryId: 3),
    IncludeItem(id: 18, name: 'Entrada de parques', includeCategoryId: 4),
    IncludeItem(id: 19, name: 'Entrada para eventos', includeCategoryId: 4),
    IncludeItem(id: 20, name: 'Tarifa de entrada', includeCategoryId: 4),
  ];
  RxBool loading = false.obs;
  RxList<int> includes = RxList<int>();
  RxList<GalleryItem> galleryItems = RxList<GalleryItem>();
  Rx<TourView> tour = TourView().obs;
  Rx<AgencyView> agency = AgencyView().obs;
  final TourService _service = Get.find<TourService>();
  final UserService _userService = Get.find<UserService>();

  @override
  void onInit() async {
    super.onInit();
    loading.value = true;
    TourView res = await _service.getByid(Get.parameters["id"]);
    tour.value = res;

    AgencyView data = await _userService.getAgencyByPRID(res.tour!.agencyId!);
    agency.value = data;

    for (var i = 0; i < res.images!.length; i++) {
      galleryItems.add(GalleryItem(
          id: 'tag_${res.images![i]}',
          url: '${AppConfig.API_URL}/file/${res.images![i]}'));
    }

    includes.value = res.tour!.includesList!;

    loading.value = false;
  }

  void toReserve(TourView tour) {
    Get.toNamed('${Routes.TOUR_RESERVE}?id=${tour.tour!.id}');
  }

  void share(Tour tour) async {
    await Share.share(
        '¡Echale un vistazo al ${tour.title} en DISCOVER RD! https://discoverrd.com/tour/share/${tour.id}');
  }
}
