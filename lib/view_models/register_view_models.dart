import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';
import '../repository/auth_repository.dart';
import '../routes/route_name.dart';
import '../utils/utils.dart';
import '../utils/validation.dart';

class RegisterViewModel extends GetxController{
  final _api = AuthRepository();


  final emailController = TextEditingController().obs;
  final nameController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final confirmController = TextEditingController().obs;



  String? validateRegister(String name, String email, String password, String confirmPassword) {
    if (!isNotEmpty(name)) {
      return "Vui lòng nhập tên";
    } else if (!isNotEmpty(email)) {
      return "Vui lòng nhập email";
    } else if (!isValidEmail(email)) {
      return "Vui lòng nhập một địa chỉ email hợp lệ";
    } else if (!isNotEmpty(password)) {
      return "Vui lòng nhập mật khẩu";
    }else if (password != confirmPassword) {
      return "Mật khẩu không khóp nhau";
    }
    return null;
  }



  RxBool loading = false.obs;

  void registerApi() {
    loading.value = true;

    UserModel user = UserModel(
      name: nameController.value.text.trim(),
      email: emailController.value.text.trim(),
      password: passwordController.value.text.trim(),
      role: "manage",
    );

    Map<String, dynamic> data = user.toJson();



    _api.register(data).then((value) {
      loading.value = false;
      Utils.snackBar("Register", "Register Success!");
      Get.toNamed(RouteName.salePointScreen);
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error.toString());
      Utils.snackBar("Loi", error.toString());
    });
  }

}