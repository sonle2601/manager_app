import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:manage_app/models/late_early_model.dart';
import 'package:manage_app/view/approval/leave/title_text_widget.dart';
import 'package:manage_app/view_models/task_view_models/late_early_view_model.dart';
import 'package:manage_app/view_models/task_view_models/leave_view_model.dart';

import '../../../models/leave_model.dart';
import '../../../view_models/task_view_models/employee_view_model.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/select_item/select_employee_available.dart';
import '../../../widgets/select_item/title_icon_select.dart';

class LateEarlyApprovalDetail extends StatefulWidget {
  const LateEarlyApprovalDetail({super.key});

  @override
  State<LateEarlyApprovalDetail> createState() => _LateEarlyApprovalDetailState();
}

class _LateEarlyApprovalDetailState extends State<LateEarlyApprovalDetail> {

  final lateEarlyVM = Get.put(LateEarlyViewModel());



  // String selectEmployee = "Chọn nhân viên thay thế";

  @override
  Widget build(BuildContext context) {
    var lateEarly = Get.arguments as LateEarlyModel?;
    String? createdAt = lateEarly!.createdAt; // Giả sử leave!.createdAt là một chuỗi thời gian trong định dạng chuỗi

    DateTime parsedDate = DateTime.parse(createdAt!);
    String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);

    DateTime time = DateTime.parse("1970-01-01 " + lateEarly.time.toString());
    String formattedTime = DateFormat.Hm().format(time);

    String? typeString(String? type){
      if(type == 'late'){
        return 'XIN ĐI MUỘN';
      }else{
        return 'XIN VỀ SỚM';
      }
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        elevation: 0,
        title:  AppText(
          text: '${typeString(lateEarly.type)}',
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
                      text: lateEarly!.workSchedule!.employee!.information!.hoTen.toString(),
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
                        child: AppText(text: lateEarly!.workSchedule!.employee!.information!.soDienThoai.toString(), size: 14, color: Colors.white,)
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
                text: "THÔNG TIN ${typeString(lateEarly.type!)}",
              ),
            ),
            TitleTextWidget(title: 'Ngày ', text: lateEarly.workSchedule!.date.toString()),
            TitleTextWidget(title: 'Tên ca ', text: lateEarly.workSchedule!.workShift!.name.toString()),
            TitleTextWidget(title: 'Lý do', text: lateEarly.reason.toString() ?? 'Không có lý do'),
            TitleTextWidget(title: 'Thời gian', text: formattedTime),
            TitleTextWidget(title: 'Ngày tạo', text: formattedDate),
            // SizedBox(height: 10,),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      lateEarlyVM.status.value = true;
                    });
                    lateEarlyVM.lateEarlyapproval();
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
                  onTap: (){
                    setState(() {
                      lateEarlyVM.status.value = false;
                    });
                    lateEarlyVM.lateEarlyapproval();
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
          ),
        ),
      ),

    );

  }
}
