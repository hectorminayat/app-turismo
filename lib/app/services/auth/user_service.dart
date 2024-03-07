import 'package:discoverrd/app/models/agency_view.dart';
import 'package:discoverrd/app/models/auth/agency_user.dart';
import 'package:discoverrd/app/models/auth/check_user_agency.dart';
import 'package:discoverrd/app/models/auth/customer_user.dart';
import 'package:discoverrd/app/models/auth/response_token.dart';
import 'package:discoverrd/app/models/customer_view.dart';
import 'package:discoverrd/app/models/dtos/agency_dto.dart';
import 'package:discoverrd/app/models/dtos/customer_dto.dart';
import 'package:discoverrd/app/services/base/api_service.dart';
import 'package:discoverrd/app/services/auth/token_service.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:dio/dio.dart' as dio;

class UserService {
  final TokenService _tokenService = Get.find<TokenService>();
  final ApiService _apiService = Get.find<ApiService>();

  registerCustomer(CustomerUser customerUser) async {
    try {
      final response =
          await _apiService.post('/user/customer', customerUser.toJson());
      final ResponseToken responseToken = ResponseToken.fromJson(response);
      _tokenService.saveToken(responseToken.token);
      _tokenService.setTokenExpiration(responseToken.expiration.toString());
      Map<String, dynamic> payload = Jwt.parseJwt(responseToken.token);
      _tokenService.saveUserInfo(payload);
    } catch (e) {
      _tokenService.removeToken();
      _tokenService.removeTokenExpiration();
      _tokenService.removeUserInfo();
      throw (e);
    }
  }

  registerAgency(AgencyUser agencyUser) async {
    try {
      var formData = dio.FormData.fromMap(agencyUser.toJson());

      await _apiService.post('/user/agency', formData);
    } catch (e) {
      throw (e);
    }
  }

  checkUserAgency(CheckUserAgency checkUserAgency) async {
    return await _apiService.post(
        '/user/agency/check', checkUserAgency.toJson());
  }

  updateCustomer(CustomerDto customer) async {
    try {
      var formData = dio.FormData.fromMap(customer.toJson());
      await _apiService.put('/user/customer', formData);
    } catch (e) {
      throw (e);
    }
  }

  updateAgency(AgencyDto agency) async {
    try {
      var formData = dio.FormData.fromMap(agency.toJson());
      await _apiService.put('/user/agency', formData);
    } catch (e) {
      throw (e);
    }
  }

  Future<CustomerView> getCustomerByid() async {
    try {
      var result = await _apiService.getAll('/user/customer');
      return CustomerView.fromJson(result);
    } catch (e) {
      throw (e);
    }
  }

  Future<AgencyView> getAgencyByid() async {
    try {
      var result = await _apiService.getAll('/user/agency');
      return AgencyView.fromJson(result);
    } catch (e) {
      throw (e);
    }
  }

    Future<AgencyView> getAgencyByPRID(id) async {
    try {
      var result = await _apiService.getAll('/user/agency/id/$id');
      return AgencyView.fromJson(result);
    } catch (e) {
      throw (e);
    }
  }

  Future<List<AgencyView>> getPopularAgency() async {
    try {
      var result = await _apiService.getAll('/user/agency/popular');
      var list = result.map((data) => AgencyView.fromJson(data)).toList();
      return List<AgencyView>.from(list);
    } catch (e) {
      throw (e);
    }
  }
}
