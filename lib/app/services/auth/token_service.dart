import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TokenService extends GetxService {

  static const TOKEN_KEY = 'auth_token';
  static const TOKEN_EXPRIRE = 'expiration_token';
  static const USER_INFO = 'user_info';

  final storage = GetStorage();

  String? getToken() {
    return storage.read(TOKEN_KEY)?.toString();
  }

  getTokenExpiration() {
    return storage.read(TOKEN_EXPRIRE);
  }

  getUserInfo() {
    return storage.read(USER_INFO);
  }

  saveToken(accessToken) {
    storage.write(TOKEN_KEY, accessToken);
  }

  setTokenExpiration(expiration) {
    storage.write(TOKEN_EXPRIRE, expiration);
  }

  removeToken() {
    storage.remove(TOKEN_KEY);
  }

  removeTokenExpiration() {
    storage.remove(TOKEN_EXPRIRE);
  }

  saveUserInfo(user) {
    storage.write(USER_INFO, user);
  }

  removeUserInfo() {
    storage.remove(USER_INFO);
  }
}
