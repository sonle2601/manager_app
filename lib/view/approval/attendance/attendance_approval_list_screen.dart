import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_app/view/approval/late_early/late_early_approval_widget.dart';
import 'package:manage_app/view_models/task_view_models/attendance_view_model.dart';
import 'package:manage_app/view_models/task_view_models/late_early_view_model.dart';

import '../../../widgets/app_text.dart';
import 'attendance_approval_widget.dart';

class AttendanceApprovalListScreen extends StatelessWidget {
  AttendanceApprovalListScreen({super.key});
   final attendanceVM = Get.put(AttendanceViewModel());


   @override
  Widget build(BuildContext context) {
     attendanceVM.getAttendanceRequets();

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.9),
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const AppText(
          text: "Duyệt xin đi muộn/về sớm",
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
      body: Obx(() {
        if(attendanceVM.loadData.value){
          return ListView.builder(
              itemCount: attendanceVM.atendancesRequest.length,
              itemBuilder: (context, index){
                var attendance = attendanceVM.atendancesRequest[index];
                return AttendanceApprovalWidget(
                    onTap: (){
                      attendanceVM.attendanceDetail(attendance);
                    },
                    employeeName: attendance.workSchedule!.employee!.information!.hoTen.toString(),
                    nameWorkShift: attendance.workSchedule!.workShift!.name.toString(),
                    date: attendance.workSchedule!.date.toString());
              }
          );
        }else{
          return Center(child: CircularProgressIndicator());
        }
      })
    );
  }
}
