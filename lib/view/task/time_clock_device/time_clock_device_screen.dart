import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_app/view_models/task_view_models/work_shift_view_model.dart';
import 'package:manage_app/widgets/work_shift_widget.dart';

import '../../../routes/route_name.dart';
import '../../../widgets/app_text.dart';

class TimeClockDeviceScreen extends StatelessWidget {
  TimeClockDeviceScreen({super.key});

  final WorkShiftViewModel workShiftViewModel = Get.put(WorkShiftViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.93),
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const AppText(
          text: "Thiết bị chấm công",
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
      body: Stack(
        children: [
          Obx(() {
            if (workShiftViewModel.workShifts.isEmpty) {
              return Center(
                child: CircularProgressIndicator(), // Vòng loading
              );
            } else {
              return ListView.builder(
                itemCount: workShiftViewModel.workShifts.length,
                itemBuilder: (context, index) {
                  var workShift = workShiftViewModel.workShifts[index];
                  return WorkShiftWidget(
                    title: workShift.name.toString(),
                    status: status(workShift.status ?? 0),
                    onTap: () {
                      workShiftViewModel.UpdateWorkShift(workShift);
                    }, // Thêm xử lý khi widget được nhấn vào
                    startTime: workShift.startTime.toString(),
                    endTime: workShift.endTime.toString(),
                  );
                },
              );
            }
          }),
          Positioned(
            bottom: 30,
            right: 30,
            child: FloatingActionButton(
              onPressed: () {
                workShiftViewModel.isUpdating = false.obs;
                AddWorkShift();
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}


int status(int statusValue) {
  return statusValue == 1 ? 1 : 0;
}
void AddWorkShift() {
  Get.toNamed(RouteName.workShiftWidget);
}
