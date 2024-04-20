import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_app/view/home/home_info_widget.dart';

import '../../routes/route_name.dart';
import '../../widgets/app_text.dart';
import 'button_home_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    String getGreeting() {
      var now = DateTime.now();
      var hour = now.hour;

      if (hour < 12) {
        return 'Chào buổi sáng!';
      } else if (hour < 18) {
        return 'Chào buổi chiều!';
      } else {
        return 'Chào buổi tối!';
      }
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.93),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/work.jpg'), // Đường dẫn đến tệp ảnh
                  fit: BoxFit.cover, // Để ảnh phủ đầy toàn bộ kích thước của Container
                ),
              ),
                child: Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 25, left: 20, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                          text: getGreeting(),
                          size: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          ClipOval(
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white70, // Màu sắc của đường viền
                                  width: 2, // Độ dày của đường viền
                                ),
                              ),
                              child: Image.asset(
                                'assets/images/user.png',
                                scale: 13,// Đảm bảo hình ảnh được căn giữa và cắt theo hình tròn
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            children: [
                              AppText(
                                text: "Sơn Lê",
                                size: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,),
                              SizedBox(height: 5,),
                              Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.white24,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: AppText(text: "Quản lý", size: 14, color: Colors.white,)
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
            ),
            TextButton(
              onPressed: (){
                Get.toNamed(RouteName.approvalScreen);
              },
              child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    padding: EdgeInsets.all(15),
                    height: 90,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green,
                      boxShadow: [
                      BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Màu sắc của đổ bóng
                      spreadRadius: 2, // Bán kính lan rộng của đổ bóng
                      blurRadius: 5, // Độ mờ của đổ bóng
                      offset: Offset(0, 3), // Vị trí của đổ bóng (dx, dy)
                              ),
                             ],
                    ),

                    child: Row(
                      children: [
                         Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.white70, // Màu sắc của đường viền
                                width: 2, // Độ dày của đường viền
                              ),
                            ),
                            child: Image.asset(
                              'assets/images/tick-mark.png',
                              scale: 11,// Đảm bảo hình ảnh được căn giữa và cắt theo hình tròn
                            ),
                          ),
                          SizedBox(width: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                  text: "Phê duyệt",
                                  size: 23,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                              ),
                              AppText(
                                text: "duyệt các yêu cầu từ nhân viên!",
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                              ),
                            ],
                          ),
                      ],
                    ),
                ),
            ),
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5, // Giảm bán kính lan rộng của đổ bóng
                    blurRadius: 5, // Giảm độ mờ của đổ bóng
                    offset: Offset(0, 5), // Giảm độ lệch của đổ bóng
                  ),
                ],
              ),

              child: Column(
                children: [
                  AppText(text: "Thông tin hôm nay",
                      fontWeight: FontWeight.bold,
                      size: 18,
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: HomeInfoWidget(
                            title: 'nhân viên đi muộn',
                            image: 'late.png',
                            number: '0',)
                        ),
                        SizedBox(width: 15,),
                        Expanded(
                          child: HomeInfoWidget(
                            title: 'nhân viên về sớm',
                            image: 'soon.png',
                            number: '0',
                        ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: HomeInfoWidget(
                            title: 'nhân viên xin nghỉ ca',
                            image: 'comfort.png',
                            number: '0',
                          ),
                        ),
                        SizedBox(width: 15,),
                      ],
                    ),
                  ),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
