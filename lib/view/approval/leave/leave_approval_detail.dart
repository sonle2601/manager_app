import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:manage_app/view/approval/leave/title_text_widget.dart';
import 'package:manage_app/view_models/task_view_models/leave_view_model.dart';

import '../../../models/leave_model.dart';
import '../../../view_models/task_view_models/employee_view_model.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/select_item/select_employee_available.dart';

class LeaveApprovalDetail extends StatefulWidget {
  const LeaveApprovalDetail({super.key});

  @override
  State<LeaveApprovalDetail> createState() => _LeaveApprovalDetailState();
}

class _LeaveApprovalDetailState extends State<LeaveApprovalDetail> {

  final employeeVM = Get.put(EmployeeViewModel());
  final leaveVM = Get.put(LeaveViewModel());



  String selectEmployee = "Chọn nhân viên thay thế";

  @override
  Widget build(BuildContext context) {
    var leave = Get.arguments as LeaveModel?;
    employeeVM.date = leave!.workSchedule!.date.toString();
    employeeVM.workShiftId = leave!.workSchedule!.workShiftId.toString();
    String? createdAt = leave!.createdAt; // Giả sử leave!.createdAt là một chuỗi thời gian trong định dạng chuỗi

    DateTime parsedDate = DateTime.parse(createdAt!);

    String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);


    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const AppText(
          text: "Danh sách xin nghỉ",
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
                      text: leave!.workSchedule!.employee!.information!.hoTen.toString(),
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
                        child: AppText(text: leave!.workSchedule!.employee!.information!.soDienThoai.toString(), size: 14, color: Colors.white,)
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
                text: "THÔNG TIN XIN NGHỈ",
              ),
            ),
            TitleTextWidget(title: 'Ngày nghỉ', text: leave.workSchedule!.date.toString()),
            TitleTextWidget(title: 'Ca nghỉ', text: leave.workSchedule!.workShift!.name.toString()),
            TitleTextWidget(title: 'Lý do nghỉ', text: leave.reason.toString() ?? 'Không có lý do'),
            TitleTextWidget(title: 'Ngày tạo', text: formattedDate),
            // SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.black12,
              height: 1,
            ),
            GestureDetector(
              onTap: (){
                SelectEmployeeAvailable.showSelectEmployee(context, (id, nameEmployee) {
                  setState(() {
                    leaveVM.employeeId = id.toString();
                    selectEmployee = nameEmployee.toString();
                    print(id);
                  });
                },
                );
              },
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(text: selectEmployee.toString()),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
              )

            ),
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
                      leaveVM.status.value = true;
                    });
                    leaveVM.approvalLeave();
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
                      leaveVM.status.value = false;
                    });
                    leaveVM.approvalLeave();
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
