import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_app/view/approval/late_early/late_early_approval_widget.dart';
import 'package:manage_app/view_models/task_view_models/late_early_view_model.dart';

import '../../../widgets/app_text.dart';

class LateEarlyApprovalListScreen extends StatelessWidget {
  LateEarlyApprovalListScreen({super.key});
   final lateEarlyVM = Get.put(LateEarlyViewModel());


   @override
  Widget build(BuildContext context) {
     lateEarlyVM.getLateEarlyRequets();

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
        if(lateEarlyVM.loadData.value){
          return ListView.builder(
              itemCount: lateEarlyVM.lateEarlyRequest.length,
              itemBuilder: (context, index){
                var lateEarly = lateEarlyVM.lateEarlyRequest[index];
                return LateEarlyApprovalWidget(
                    onTap: (){
                      lateEarlyVM.lateEarlyDetail(lateEarly);
                    },
                    employeeName: lateEarly.workSchedule!.employee!.information!.hoTen.toString(),
                    nameWorkShift: lateEarly.workSchedule!.workShift!.name.toString(),
                    reason: lateEarly.reason.toString(),
                    type: lateEarly.type.toString(),
                    date: lateEarly.workSchedule!.date.toString());
              }
          );
        }else{
          return Center(child: CircularProgressIndicator());
        }
      })
    );
  }
}
