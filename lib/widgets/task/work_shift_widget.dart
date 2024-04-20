import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_app/view_models/task_view_models/work_shift_view_model.dart';
import 'package:manage_app/widgets/button_bottom.dart';

import '../../utils/utils.dart';
import '../../view_models/task_view_models/parts_view_model.dart';
import '../app_text.dart';
import '../app_text_area.dart';
import '../select_item/select_time.dart';

class WorkShiftWidget extends StatefulWidget {
   WorkShiftWidget({super.key});

  @override
  State<WorkShiftWidget> createState() => _WorkShiftWidgetState();
}

class _WorkShiftWidgetState extends State<WorkShiftWidget> {
  final workShiftVM = Get.put(WorkShiftViewModel());
  String textStatus = 'Đang hoạt động';




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        elevation: 0,
        title:  Obx(() =>
            AppText(
              text: workShiftVM.isUpdating.value ? "Cập nhật làm việc" : "Tạo ca làm việc",
              size: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () {
            workShiftVM.resetTextField();
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
      body:  Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),
                AppTextArea(
                  textEditingController: workShiftVM.nameController.value,
                  hintText: "Tên ca làm việc",
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                    SelectTime.selectTime(context, (int hour, int minute) {
                      workShiftVM.startTimeController.value.text = '$hour:$minute';                    });
                  },
                  child: AppTextArea(
                    textEditingController: workShiftVM.startTimeController.value,
                    hintText: "Thời gian bắt đầu",
                    enable: false,
                    icon: Icon(Icons.access_time), // Sử dụng biểu tượng thời gian ở đây
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    SelectTime.selectTime(context, (int hour, int minute) {
                      workShiftVM.endTimeController.value.text = '$hour:$minute';
                    });
                  },
                  child: AppTextArea(
                    textEditingController: workShiftVM.endTimeController.value,
                    hintText: "Thời gian kết thúc",
                    enable: false,
                    icon: Icon(Icons.access_time), // Sử dụng biểu tượng thời gian ở đây
                  ),
                ),

                SizedBox(height: 40,),
                if (workShiftVM.isUpdating.value)  Container(
                  margin: EdgeInsets.only(left: 22, right: 22, bottom: 30),
                  child: Row(
                    children: [
                      AppText(
                        text: workShiftVM.textStatus, color: Colors.black54,
                      ),
                      Switch(
                        value: workShiftVM.switchValue.value, // Sử dụng giá trị cục bộ
                        onChanged: (bool newValue) {
                          setState(() {
                            workShiftVM.switchValue.value = newValue;
                            workShiftVM.textStatus = workShiftVM.switchValue.value ? "Đang hoạt động" : "Ngưng hoạt động";
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50,),
              ],
            ),
          ),

          Positioned(
            bottom: 20,
            left: 10,
            right: 10,
            child: Obx(() =>
                ButtonButtom(
                  loading: workShiftVM.loading.value,
                  title: workShiftVM.isUpdating.value ? "Cập nhật" : "Tạo mới",
                  onPress: () {
                    String? validationError = workShiftVM.validate(
                        workShiftVM.nameController.value.text,
                      workShiftVM.startTimeController.value.text,
                      workShiftVM.endTimeController.value.text
                    );
                    if (validationError != null) {
                      Utils.snackBar("Lỗi", validationError.toString());
                    } else {
                      if (workShiftVM.isUpdating.value) {
                        workShiftVM.UpdateWorkShiftApi();
                      } else {
                        workShiftVM.addWorkShiftApi();
                      }
                      Get.back();
                    }
                  },
                ),
            ),
          ),
        ],

      ),
    );
  }
}
