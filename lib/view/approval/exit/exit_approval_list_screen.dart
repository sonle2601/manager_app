import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_app/view_models/task_view_models/leave_view_model.dart';

import '../../../routes/route_name.dart';
import '../../../view_models/task_view_models/employee_view_model.dart';
import '../../../view_models/task_view_models/exit_view_model.dart';
import '../../../widgets/app_text.dart';
import 'exit_approval_widget.dart';

class ExitApprovalListScreen extends StatelessWidget {
  ExitApprovalListScreen({super.key});
   final exitVM = Get.put(ExitViewModel());


   @override
  Widget build(BuildContext context) {
    exitVM.getExitRequets();

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.9),
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const AppText(
          text: "Xin ra ngoài",
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
        if(exitVM.loadData.value){
          return ListView.builder(
              itemCount: exitVM.exitRequest.length,
              itemBuilder: (context, index){
                var exit = exitVM.exitRequest[index];
                return ExitApprovalWidget(
                    onTap: (){
                      exitVM.exitDetail(exit);
                    },
                    employeeName: exit.workSchedule!.employee!.information!.hoTen.toString(),
                    nameWorkShift: exit.workSchedule!.workShift!.name.toString(),
                    reason: exit.reason.toString(),
                    date: exit.workSchedule!.date.toString());
              }
          );
        }else{
          return Center(child: CircularProgressIndicator());
        }
      })
    );
  }
}
