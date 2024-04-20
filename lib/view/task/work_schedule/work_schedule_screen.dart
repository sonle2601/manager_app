import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:manage_app/view/task/work_schedule/work_date_widget.dart';
import 'package:manage_app/view/task/work_schedule/work_shift_widget.dart';
import 'package:manage_app/view_models/task_view_models/work_shift_view_model.dart';
import 'package:manage_app/widgets/select_item/select_employee.dart';

import '../../../view_models/task_view_models/work_schedule_view_model.dart';
import '../../../widgets/app_text.dart';

class WorkScheduleScreen extends StatefulWidget {
  const WorkScheduleScreen({super.key});

  @override
  State<WorkScheduleScreen> createState() => _WorkScheduleScreenState();
}

class _WorkScheduleScreenState extends State<WorkScheduleScreen> {


  @override
  Widget build(BuildContext context) {
    final WorkShiftViewModel workShiftVM = Get.put(WorkShiftViewModel());
    final WorkScheduleViewModel workScheduleVM = Get.put(WorkScheduleViewModel());
    workScheduleVM.getworkSchedule();


    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.93),
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const AppText(
          text: "Lịch làm việc",
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
      body: Column(
        children: [
         Container(
              height: 130,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: WorkDateWidget(
                onDateSelected: (time) {
                  setState(() {
                    workScheduleVM.date = DateFormat('yyyy-MM-dd').format(time);
                    workScheduleVM.dateAdd = DateFormat('yyyy-MM-dd').format(time);
                  });
                },
              ),
            ),
          SizedBox(height: 5,),
          Obx(() {
        if (workShiftVM.loadData.value) {
          return Expanded(
            child: ListView.builder(
              itemCount: workShiftVM.workShifts.length,
              itemBuilder: (context, index) {
                var workShifts = workShiftVM.workShifts[index];
                return WorkShiftWidget(
                  onTap: (){
                    SelectEmployee.showSelectEmployee(context, (idEmployee) {
                      setState(() {
                        workScheduleVM.idEmployee = idEmployee ;
                        workScheduleVM.idWorkShifts = workShifts.id;
                      });
                       workScheduleVM.addWorkSchedule();
                    });
                  },
                  id: workShifts.id,
                  nameWorkShift: workShifts.name.toString(),
                  timeStart: workShifts.startTime.toString(),
                  timeEnd: workShifts.endTime.toString(),
                  quantity: 2,
                );
              },
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }),

        ],
      ),
    );
  }
}
