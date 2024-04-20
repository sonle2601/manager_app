import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:manage_app/view_models/user_prefrence_view_model.dart';

import '../models/token_model.dart';
import '../models/user_model.dart';
import '../repository/auth_repository.dart';
import '../routes/route_name.dart';
import '../utils/utils.dart';
import '../utils/validation.dart';

class LoginViewModel extends GetxController{

  final _api = AuthRepository();
  UserPreference userPreference = UserPreference();
  static final _firebaseMessaging = FirebaseMessaging.instance;



  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  String? validateLogin(String email, String password) {
     if (!isNotEmpty(email)) {
      return "Vui lòng nhập email";
    } else if (!isValidEmail(email)) {
      return "Vui lòng nhập một địa chỉ email hợp lệ";
    } else if (!isNotEmpty(password)) {
      return "Vui lòng nhập mật khẩu";
    }
    return null;
  }

  RxBool loading = false.obs;

  void loginApi() {
    loading.value = true;



    UserModel user = UserModel(
      email: emailController.value.text.trim(),
      password: passwordController.value.text.trim(),
    );

    Map<String, dynamic> data = user.toJson();

    _api.login(data).then((value) {
      loading.value = false;
      print(value.toString());

      TokenModels token = TokenModels(
        token: value['token'],
        isLogin: true,
      );

      String tokenString = value['token'];
      Map<String, dynamic> decodedToken = JwtDecoder.decode(tokenString);
      String role = decodedToken['role'];
      // print('Role: $role');

      if(role.toString() == 'manager'){
        userPreference.saveUser(token).then((value) async {
          AuthRepository _api = AuthRepository();
          final infoCheck = await _api.checkStore();
          if (infoCheck['store_exists'] == true) {
            String? tokenDevice = await _firebaseMessaging.getToken();
            print('token_device '+tokenString.toString());
            Map<String, dynamic> data = {
              'token_device': tokenDevice,
            };
            final update = await _api.update(data);
            Get.offAllNamed(RouteName.mainScreen);
          } else {
            Get.toNamed(RouteName.storeScreen);
          }
        }).onError((error, stackTrace) {

        });

        Utils.snackBar("Login", "Login Success!");
      }else if(role.toString() == 'staff'){
        Utils.snackBar("Lỗi", "Tài khoản của bạn đã đăng kí với vai trò nhân viên");
      }else {
        Utils.snackBar("Lỗi", "Tài khoản của bạn chưa được đăng kí");
      }


    }).onError((error, stackTrace) {
      loading.value = false;
      print(error.toString());
      Utils.snackBar("Loi", error.toString());
    });
  }


}