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
        automaticallyImplyLeading: false, // Ẩn nút back
        title: const AppText(
          text: "Thông báo",
          size: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.assignment),
            onPressed: () {
              // Xử lý khi ấn vào nút task
              // Đánh dấu là đã đọc
            },
          ),
        ],
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
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: .5,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal:20, vertical: 10 ),
                        color: Colors.blueAccent.withOpacity(0.1),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              height: 30,
                              child: Image.asset('assets/images/notification-bell.png'),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                    text: notification.title.toString(),
                                    fontWeight: FontWeight.bold,
                                ),
                                SizedBox(height: 8),
                                Container(
                                  child: AppText(
                                      text: notification.content.toString(),
                                      maxLines: 2,
                                  ),
                                  width: MediaQuery.of(context).size.width*3/4,
                                ),
                                SizedBox(height: 8),
                                AppText(
                                    color: Colors.grey,
                                    text: FormatUtils.formatDateString(notification.createdAt.toString())
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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
