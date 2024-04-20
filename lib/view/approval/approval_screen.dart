import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/route_name.dart';
import '../../widgets/app_text.dart';
import '../home/button_home_widget.dart';

class ApprovalScreen extends StatefulWidget {
  const ApprovalScreen({super.key});

  @override
  State<ApprovalScreen> createState() => _ApprovalScreenState();
}

class _ApprovalScreenState extends State<ApprovalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.98),
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const AppText(
          text: "Chờ phê duyệt",
          size: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(.20),
          child: Container(
            height: .4,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 11, right: 11),
            color: Colors.grey,
          ),
        ),
      ),
      body: Container(
        height: 300,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ButtonHomeWidget(
                      onTap: (){
                        Get.toNamed(RouteName.lateEarlyApprovalListScreen);
                      },
                      title: 'Xin đi muộn/về sớm',
                      image: 'assets/images/late.png',
                      content: 'Duyệt xin đi muộn',
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: ButtonHomeWidget(
                      onTap: (){
                        Get.toNamed(RouteName.leaveApprovalListScreen);
                      },
                      title: 'Duyệt nghỉ ca',
                      image: 'assets/images/comfort.png',
                      content: 'Duyệt nghỉ ca làm',
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
                    child: ButtonHomeWidget(
                      onTap: (){
                        Get.toNamed(RouteName.exitApprovalListScreen);
                      },
                      title: 'Xin ra ngoài',
                      image: 'assets/images/out.png',
                      content: 'Duyệt nhân viên muốn xin ra ngoài',
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: ButtonHomeWidget(
                      onTap: (){
                        Get.toNamed(RouteName.attendanceApprovalListScreen);
                      },
                      title: 'Chấm công bổ sung',
                      image: 'assets/images/duyet_cham_cong.png',
                      content: 'Duyệt chấm công bổ sung',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
