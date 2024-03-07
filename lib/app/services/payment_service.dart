import 'package:discoverrd/app/models/invoice.dart';
import 'package:discoverrd/app/services/base/api_service.dart';
import 'package:get/get.dart';

class PaymentService {
  final ApiService _apiService = Get.find<ApiService>();

  Future<dynamic> createInvoice(Invoice invoice) async {
    try {
      return await _apiService.post('/payment/invoice', invoice.toJson());
    } catch (e) {
      throw (e);
    }
  }
}
