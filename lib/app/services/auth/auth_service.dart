import 'package:discoverrd/app/models/auth/response_token.dart';
import 'package:discoverrd/app/services/base/api_service.dart';
import 'package:discoverrd/app/services/auth/token_service.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthService {

  final TokenService _tokenService = Get.find<TokenService>();
  final ApiService _apiService = Get.find<ApiService>();


  login(String email, String password) async {
    try {
      final response = await _apiService.post('/auth/login', {'email': email, 'password': password});
      final ResponseToken responseToken = ResponseToken.fromJson(response);
      _tokenService.saveToken(responseToken.token);
      Map<String, dynamic> payload = Jwt.parseJwt(responseToken.token);
      print(payload);
      _tokenService.saveUserInfo(payload);
      _tokenService.setTokenExpiration(responseToken.expiration.toString());
    } catch (e) {
      _tokenService.removeToken();
      _tokenService.removeTokenExpiration();
      _tokenService.removeUserInfo();
      throw(e);
    }
  }
  logout() {
    _tokenService.removeToken();
    _tokenService.removeTokenExpiration();
    _tokenService.removeUserInfo();
  }

}