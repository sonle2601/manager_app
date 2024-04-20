import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:manage_app/models/exit_model.dart';
import 'package:manage_app/view/approval/leave/title_text_widget.dart';
import 'package:manage_app/view_models/task_view_models/exit_view_model.dart';
import 'package:manage_app/view_models/task_view_models/leave_view_model.dart';

import '../../../models/leave_model.dart';
import '../../../view_models/task_view_models/employee_view_model.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/select_item/select_employee_available.dart';
import '../../../widgets/select_item/title_icon_select.dart';

class ExitApprovalDetail extends StatefulWidget {
  const ExitApprovalDetail({super.key});

  @override
  State<ExitApprovalDetail> createState() => _ExitApprovalDetailState();
}

class _ExitApprovalDetailState extends State<ExitApprovalDetail> {

  final exitVM = Get.put(ExitViewModel());




  @override
  Widget build(BuildContext context) {
    var exit = Get.arguments as ExitModel?;
    log(exit!.status.toString());
    String? createdAt = exit!.createdAt; // Giả sử leave!.createdAt là một chuỗi thời gian trong định dạng chuỗi

    DateTime parsedDate = DateTime.parse(createdAt!);

    String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);


    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const AppText(
          text: "Chi tiết xin ra ngoài",
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
        margin: EdgeInsets.all(15),
        child: Column(
          children: [
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
                        color: Colors.black12, // Màu sắc của đường viền
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: exit!.workSchedule!.employee!.information!.hoTen.toString(),
                      size: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,),
                    SizedBox(height: 5,),
                    Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: AppText(text: exit!.workSchedule!.employee!.information!.soDienThoai.toString(), size: 14, color: Colors.white,)
                    )
                  ],
                )
              ],
            ),
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width,
              color: Colors.black12,
              child: AppText(
                text: "THÔNG TIN XIN RA NGOÀI",
              ),
            ),
            TitleTextWidget(title: 'Ngày', text: exit.workSchedule!.date.toString()),
            TitleTextWidget(title: 'Tên ca', text: exit.workSchedule!.workShift!.name.toString()),
            TitleTextWidget(title: 'Lý do ra ngoài', text: exit.reason.toString() ?? 'Không có lý do'),
            TitleTextWidget(title: 'Thời gian ra', text: '${exit.minutesOut.toString()} phút' ),
            TitleTextWidget(title: 'Ngày tạo', text: formattedDate),
            // SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.black12,
              height: 1,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 70,
          child: Builder(
            builder: (context) {
              if (exit.status == 'pending') {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            exitVM.status.value = true;
                          });
                          exitVM.approvalExit();
                          Get.back();
                        },
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: AppText(
                            size: 20,
                            text: 'Đồng ý',
                            textAlign: TextAlign.center,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            exitVM.status.value = false;
                          });
                          exitVM.approvalExit();
                          Get.back();
                        },
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: AppText(
                            size: 20,
                            text: 'Từ chối',
                            textAlign: TextAlign.center,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                );
              } else if (exit.status == 'rejected') {
                return Container(
                  child: Center(child: AppText(
                    text: 'Bạn đã từ chối yêu cầu xin ra ngoài',
                    size: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  )
                  ),
                );
              } else {
                return Container(
                  child: Center(
                      child: AppText(text: 'Bạn đã đồng ý yêu cầu xin ra ngoài',
                        size: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      )
                  ),
                );
              }
            },
          ),
        ),
      ),


    );

  }
}
