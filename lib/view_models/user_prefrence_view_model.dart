
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/token_model.dart';

class UserPreference{

  Future<bool> saveUser(TokenModels responseModel)async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("token", responseModel.token.toString());
    sp.setBool("isLogin", responseModel.isLogin!);
    DateTime? expiration = extractExpirationFromToken(responseModel.token); // Đây là hàm để trích xuất thời hạn từ token
    if (expiration != null) {
      sp.setString("expiration", expiration.toIso8601String());
    }

    return true;
  }

  Future<TokenModels> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString("token");
    bool? isLogin = sp.getBool("isLogin");
    String? expirationString = sp.getString("expiration");

    DateTime? expiration;
    if (expirationString != null && expirationString.isNotEmpty) {
      expiration = DateTime.parse(expirationString);
    }

    return TokenModels(
      token: token,
      isLogin: isLogin,
      expiration: expiration
    );
  }



  Future<bool> removeUser()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    return true;
  }

  Future<String?> getToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString("token");
  }

}
DateTime? extractExpirationFromToken(String? token) {
  if (token == null) return null;

  try {
    final parts = token.split('.');
    if (parts.length != 3) return null;

    final payload = parts[1];
    final normalized = base64Url.normalize(payload);
    final decoded = utf8.decode(base64Url.decode(normalized));
    final Map<String, dynamic> json = jsonDecode(decoded);

    final int? expirationTimestamp = json['exp'];
    if (expirationTimestamp != null) {
      return DateTime.fromMillisecondsSinceEpoch(expirationTimestamp * 1000);
    } else {
      return null;
    }
  } catch (e) {
    print('Error extracting expiration from token: $e');
    return null;
  }
}
