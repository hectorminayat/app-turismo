import 'package:discoverrd/app/services/base/api_service.dart';
import 'package:get/get.dart';

class StripeService {
  final ApiService _apiService = Get.find<ApiService>();

  Future<dynamic> paymentSheet(amount) async {
    try {
      return await _apiService.post('/stripe/paymentsheet', {"amount": amount});
    } catch (e) {
      throw (e);
    }
  }
}
