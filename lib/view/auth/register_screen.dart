import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/utils.dart';
import '../../view_models/register_view_models.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/round_button.dart';



class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final registerVM = Get.put(RegisterViewModel());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 60,),
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
            SizedBox(height: 50,),
            Form(
              key: _formKey,
              child: Column(

                children: [
                  AppTextField(
                    // title: "Name",
                    //   message: 'Name enter',
                      textEditingController: registerVM.nameController.value,
                      hintText: "Full Name",
                      icon: Icons.person
                  ),
                  SizedBox(height: 20,),
                  AppTextField(
                      // title: "Email",
                      // message: 'Email enter',
                      textEditingController: registerVM.emailController.value,
                      hintText: "Email",
                      icon: Icons.email
                  ),

                  SizedBox(height: 20,),
                  AppTextField(
                      obscureText: true,
                      textEditingController: registerVM.passwordController.value,
                      hintText: "Password",
                      icon: Icons.password_outlined
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            AppTextField(
                obscureText: true,
                textEditingController: registerVM.confirmController.value,
                hintText: "Confirm Password",
                icon: Icons.password_outlined
            ),

            SizedBox(height: 40,),
            Obx(() => RoundButton(
                width: 200,
                title: 'Register',
                loading: registerVM.loading.value,
                onPress: (){
                  String? validationError = registerVM.validateRegister(
                    registerVM.nameController.value.text,
                    registerVM.emailController.value.text,
                    registerVM.passwordController.value.text,
                    registerVM.confirmController.value.text,
                  );
                  if (validationError != null) {
                    Utils.snackBar("Lỗi", validationError.toString());
                  } else {
                    registerVM.registerApi(); // Gọi hàm đăng ký từ ViewModel
                  }
                }
            ),
            ),
            SizedBox(height: 15,),
            RichText(
                text: TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                    text: "Have an account already?",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    )
                )
            )
          ],
        ),
      ),
    );
  }
}
