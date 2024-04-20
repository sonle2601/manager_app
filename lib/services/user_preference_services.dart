
import 'dart:async';

import 'package:get/get.dart';

import '../repository/auth_repository.dart';
import '../routes/route_name.dart';
import '../view_models/user_prefrence_view_model.dart';

class UserPreferenceServices{

  UserPreference userPreference = UserPreference();


  Future<bool> isLogin() async {
    try {
      final userInfo = await userPreference.getUser();
      DateTime now = DateTime.now();
      if (userInfo.isLogin == false || userInfo.isLogin.toString() == 'null' || userInfo.expiration!.isBefore(now)) {
        await Future.delayed(const Duration(seconds: 3));
        Get.toNamed(RouteName.loginScreen);
      }else{
        AuthRepository _api = AuthRepository();
      final infoCheck = await _api.checkStore();
        if (infoCheck['store_exists'] == true) {
          Get.toNamed(RouteName.mainScreen);
        } else {
          Get.toNamed(RouteName.storeScreen);
        }
      }
    } catch (error) {
      print("loi"+error.toString());
    }
    return true;

  }


}