import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_app/view/account/image_content_widget.dart';
import 'package:manage_app/widgets/app_text.dart';

import '../../routes/route_name.dart';
import '../../view_models/information_view_model.dart';

class AccountScreen extends StatelessWidget {
   AccountScreen({Key? key});
  final infoVM = Get.put(InformationViewModel());


  @override
  Widget build(BuildContext context) {
    infoVM.getInforUser();
    return Scaffold(
      body: Obx(() {
        if(infoVM.loadData.value){
          return Container(
            padding: EdgeInsets.only(top: 45, left: 25, right: 25),
            child: Column(
              children: [
                ImageContentWidget(
                    onTap: (){
                      infoVM.updateInfoScreen(infoVM.userInfor.value);
                    },
                    image: 'assets/images/user.png',
                    title: infoVM.userInfor.value.name.toString(),
                    description: 'Chỉnh sửa thông tin cá nhân'
                ),
                ImageContentWidget(
                    onTap: (){
                      Get.toNamed(RouteName.passwordChangeScreen);
                    },
                    image: 'assets/images/padlock.png',
                    title: "Bảo mật",
                    description: 'Đổi mật khẩu'
                ),
                ImageContentWidget(
                    image: 'assets/images/logout.png',
                    title: "Đăng xuất",
                    description: 'Đăng xuất khỏi hệ thống'
                ),
              ],
            ),
          );
        }else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      })
    );
  }
}
