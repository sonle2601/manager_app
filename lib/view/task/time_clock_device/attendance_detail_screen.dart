import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:manage_app/view/approval/leave/title_text_widget.dart';

import '../../../view_models/task_view_models/attendance_view_model.dart';
import '../../../widgets/app_text.dart';

class AttendanceDetailScreen extends StatelessWidget {
  AttendanceDetailScreen({super.key});
  final attendanceVM = Get.put(AttendanceViewModel());

  int daysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  bool isAttendanceAvailable(DateTime date) {
    final formattedDate = DateFormat('yyyy-MM-dd').format(date);
    return attendanceVM.atendances.any((attendance) => attendance.date == formattedDate);
  }

  @override
  Widget build(BuildContext context) {
    attendanceVM.getAttendance();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const AppText(
          text: "Chi tiết chấm công",
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
          preferredSize: const Size.fromHeight(0.20),
          child: Container(
            height: 0.4,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 11, right: 11),
            color: Colors.grey,
          ),
        ),
      ),
      body: Obx(() {
        if (attendanceVM.loadData == true) {
          return ListView.builder(
            itemCount: daysInMonth(DateTime.now().year, DateTime.now().month),
            itemBuilder: (context, index) {
              final dayOfMonth = index + 1;
              final date = DateTime(DateTime.now().year, DateTime.now().month, dayOfMonth);
              final attendancesForDate = attendanceVM.atendances.where((attendance) => attendance.date == DateFormat('yyyy-MM-dd').format(date)).toList();
              if (attendancesForDate.isNotEmpty) {
                return Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.all(15),
                      height: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.lightGreen.withOpacity(0.5),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black12,
                            ),
                            alignment: Alignment.center,
                            child: AppText(
                              text: DateFormat('dd/MM/yyyy').format(date), // Format ngày tháng
                              fontWeight: FontWeight.bold,
                              size: 18,
                              color: Colors.black87,
                            ),
                          ),
                          Container(
                            height: 310,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: attendancesForDate.length,
                              itemBuilder: (context, index) {
                                var attendance = attendancesForDate[index];
                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent.withOpacity(0.1),
                                        ),
                                        alignment: Alignment.topLeft,
                                        child: AppText(
                                          text: attendance.workSchedule!.workShift!.name.toString(),
                                          fontWeight: FontWeight.bold,
                                          size: 18,
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                      TitleTextWidget(title: 'Thời gian ca', text: '${attendance.workSchedule!.workShift!.startTime.toString()} đến ${attendance.workSchedule!.workShift!.endTime.toString()}' ),
                                      TitleTextWidget(title: 'Thời gian đến', text: attendance.checkIn.toString()),
                                      TitleTextWidget(title: 'Thời gian về', text: attendance.checkOut.toString()),
                                      TitleTextWidget(title: 'Ra ngoài', text: '${attendance.minutesOut.toString()} phút'),
                                      TitleTextWidget(title: 'Tổng thời gian', text: convertMinutesToHoursAndMinutes(attendance.totalMinutes)),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(15),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.lightGreen.withOpacity(0.5),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black12,
                    ),
                    alignment: Alignment.center,
                    child: AppText(
                      text: DateFormat('dd/MM/yyyy').format(date), // Format ngày tháng
                      fontWeight: FontWeight.bold,
                      size: 18,
                      color: Colors.black87,
                    ),
                  ),
                );
              }
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
String convertMinutesToHoursAndMinutes(int? minutes) {
  if(minutes == null || minutes < 0){
    return '0 phút';
  }

  int hours = minutes ~/ 60;
  int remainingMinutes = minutes % 60;

  if (hours > 0 && remainingMinutes > 0) {
    return '$hours giờ $remainingMinutes phút';
  } else if (hours > 0 && remainingMinutes == 0) {
    return '$hours giờ';
  } else {
    return '$remainingMinutes phút';
  }
}





