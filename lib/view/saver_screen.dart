import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/route_name.dart';
import '../utils/utils.dart';
import '../view_models/user_prefrence_view_model.dart';

class SaverScreen extends StatelessWidget {
   SaverScreen({super.key});
  UserPreference _userPreference = UserPreference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onTap: (){
              _userPreference.removeUser().then((value) {
                Get.toNamed(RouteName.loginScreen);
              } ).onError((error, stackTrace) {
                Utils.snackBar("Loi", "Xay ra loi"+error.toString());
              });
            },
            child: Container(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(top: 40, right: 20),
                height: 30,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black12
                ),
                child: Center(
                  child: Text(
                      "Đăng xuất",
                    style: TextStyle(
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 120,),
          Container(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/complete_icon.png', // Đường dẫn tới hình ảnh hoặc logo
                  width: 150, // Kích thước của hình ảnh hoặc logo
                  height: 150,
                ),
                SizedBox(height: 20,),
                Text(
                    "Đăng ký thành công",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.black38
                  ),
                ),

                SizedBox(height: 15,),
                Text(
                  "Để bắt đầu công việc, vui lòng nhập vào mã \n được cung cấp bởi quản lý"
                      "\n hoặc nhận lời mời từ người quản lý",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54
                  ),
                  textAlign: TextAlign.center,
                ),
                GestureDetector(
                  onTap: (){

                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 30, right: 20),
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.deepPurple
                    ),
                    child: Center(
                      child: Text(
                        "Nhập mã",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
