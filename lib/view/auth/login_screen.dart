import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/route_name.dart';
import '../../utils/utils.dart';
import '../../view_models/login_view_models.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/round_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginVM = Get.put(LoginViewModel());
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 60,),
            Center(
              child: Container(
                height: 100,
                child: const CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage(
                      "assets/images/user.jpg"
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50,),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(30),
                    alignment: Alignment.topLeft,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Xin chào",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black38
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          "Đăng nhập vào tài khoản quản lý của bạn",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black26
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppTextField(
                      textEditingController: loginVM.emailController.value,
                      hintText: "Email",
                      icon: Icons.email
                  ),

                  const SizedBox(height: 20,),
                  AppTextField(
                      obscureText: true,
                      textEditingController: loginVM.passwordController.value,
                      hintText: "Password",
                      icon: Icons.password_outlined
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40,),
            Obx(() => RoundButton(
                width: 200,
                title: 'Đăng nhập',
                loading: loginVM.loading.value,
                onPress: (){
                  String? validationError = loginVM.validateLogin(
                    loginVM.emailController.value.text,
                    loginVM.passwordController.value.text,
                  );
                  if (validationError != null) {
                    Utils.snackBar("Lỗi", validationError.toString());
                  } else {
                    loginVM.loginApi(); // Gọi hàm đăng ký từ ViewModel
                  }
                }
            ),
            ),
            const SizedBox(height: 30,),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Bạn chưa có tài khoản? ",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                  TextSpan(
                    text: "Đăng kí",
                    style: const TextStyle(
                      color: Colors.black54, // Màu đậm
                      fontSize: 18,
                      fontWeight: FontWeight.bold, // Chữ đậm
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {
                      Get.toNamed(RouteName.registerScreen);
                    },
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
