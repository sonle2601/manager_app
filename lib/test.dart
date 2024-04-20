import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_app/utils/format_util.dart';
import 'package:manage_app/view_models/task_view_models/notification_view_model.dart';

import '../routes/route_name.dart';
import '../widgets/app_text.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final  notificationVM = Get.put(NotificationViewModel());
    notificationVM.getNotification();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const AppText(
          text: "Thông báo",
          size: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
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
        if(notificationVM.loadData.value){
          return ListView.builder(
              itemCount: notificationVM.notification.length,
              itemBuilder: (context, index){
                var notification = notificationVM.notification[index];
                return GestureDetector(
                  onTap: (){
                    switch(notification.type) {
                      case 'exit_requests' :
                        Get.toNamed(RouteName.exitApprovalDetail, arguments: notification.exit);
                      case 'attendance_requests' :
                        Get.toNamed(RouteName.attendanceApprovalDetail, arguments: notification.attendance);
                      case 'late_early_requests' :
                        Get.toNamed(RouteName.lateEarlyApprovalDetail, arguments: notification.lateEarly);
                      case 'leave_requests' :
                        Get.toNamed(RouteName.leaveApprovalDetail, arguments: notification.leave);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal:20, vertical: 10 ),
                    margin: EdgeInsets.only(bottom: 10),
                    color: Colors.blueAccent.withOpacity(0.1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(text: notification.title.toString()),
                        SizedBox(height: 8),
                        AppText(text: notification.content.toString()),
                        SizedBox(height: 8),
                        AppText(text: FormatUtils.formatDateString(notification.createdAt.toString())),
                      ],
                    ),
                  ),
                );
              });
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
