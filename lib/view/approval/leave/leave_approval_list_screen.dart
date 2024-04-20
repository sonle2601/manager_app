import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_app/view_models/task_view_models/leave_view_model.dart';

import '../../../routes/route_name.dart';
import '../../../view_models/task_view_models/employee_view_model.dart';
import '../../../widgets/app_text.dart';
import 'leave_approval_widget.dart';

class LeaveApprovalListScreen extends StatelessWidget {
   LeaveApprovalListScreen({super.key});
   final leaveVM = Get.put(LeaveViewModel());


   @override
  Widget build(BuildContext context) {
    leaveVM.getLeaveRequets();

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.9),
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const AppText(
          text: "Duyệt ngày nghỉ",
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
        if(leaveVM.loadData.value){
          return ListView.builder(
              itemCount: leaveVM.leaveRequest.length,
              itemBuilder: (context, index){
                var leave = leaveVM.leaveRequest[index];
                return LeaveApprovalWidget(
                    onTap: (){
                      leaveVM.leaveDetail(leave);
                    },
                    employeeName: leave.workSchedule!.employee!.information!.hoTen.toString(),
                    nameWorkShift: leave.workSchedule!.workShift!.name.toString(),
                    reason: leave.reason.toString(),
                    date: leave.workSchedule!.date.toString());
              }
          );
        }else{
          return Center(child: CircularProgressIndicator());
        }
      })
    );
  }
}
