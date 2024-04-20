import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_app/view/task/work_schedule/work_schedule_employee_widget.dart';
import 'package:manage_app/view_models/task_view_models/work_schedule_view_model.dart';

import '../../../widgets/app_text.dart';

class WorkShiftWidget extends StatelessWidget {
  final String nameWorkShift;
  final String timeStart;
  final String timeEnd;
  final int quantity;
  final VoidCallback? onTap;
  final int? id;

  const WorkShiftWidget({
    Key? key,
    required this.quantity,
    required this.timeStart,
    required this.timeEnd,
    required this.nameWorkShift,
    this.onTap,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WorkScheduleViewModel workScheduleVM = Get.find<WorkScheduleViewModel>();


    return Obx(() {
      if (workScheduleVM.loadData.value) {
        return Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    color: Colors.black54,
                    text: "${nameWorkShift} [ ${timeStart} - ${timeEnd} ]",
                    fontWeight: FontWeight.bold,
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Container(
                      height: 25,
                      child: Image.asset('assets/images/add-user.png'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              SizedBox(height: 8,),
              Container(
                height: .6,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: workScheduleVM.workSchedule.length,
                  itemBuilder: (context, index) {
                    var workSchedules = workScheduleVM.workSchedule[index];
                    if (workSchedules.workShiftId == id) {
                      return WorkScheduleEmployeeWidget(
                        nameEmployee: workSchedules.employee!.information!.hoTen.toString(),
                        partEmployee: workSchedules.employee!.part!.partName.toString(),
                        status: workSchedules.status,
                      );
                    } else {
                      // Return a placeholder widget or null if the condition is not met
                      return SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      } else {
        return Center(child: Text(''));
      }
    });
  }
}

