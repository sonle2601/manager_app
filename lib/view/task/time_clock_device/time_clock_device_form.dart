import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_app/view_models/task_view_models/time_clock_device_view_model.dart';

import '../../../utils/utils.dart';
import '../../../view_models/task_view_models/work_shift_view_model.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/app_text_area.dart';
import '../../../widgets/button_bottom.dart';
import '../../../widgets/task/work_shift_widget.dart';

class TimeClockDeviceForm extends StatelessWidget {
   TimeClockDeviceForm({super.key});


  @override
  Widget build(BuildContext context) {
    final timeClockDeviceVM = Get.put(TimeClockDeviceViewModel());

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const AppText(
          text: "Cập nhật thiết bị chấm công",
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
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black12
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center, // Đảm bảo các thành phần được căn lề từ trên xuống
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10), // Padding cho icon
                        child: Icon(Icons.wifi),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(15), // Margin cho văn bản
                          child: AppText(
                            maxLines: 3,
                            text: 'Vui lòng kết nối wifi của bạn để chấm công.'
                                ' Sau đó ấn nút lấy thông tin wifi hiện tại để cập nhật thiết bị chấm công mới',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                    onPressed: (){
                      timeClockDeviceVM.getInfoWifi();
                    },
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey
                      ),
                      child: Center(
                        child: AppText(
                          color: Colors.white,
                          text: "Lấy thông tin Wifi hiện tại",
                        ),
                      ),
                    )
                ),
                SizedBox(height: 20,),
                AppTextArea(
                  enable: false,
                  textEditingController: timeClockDeviceVM.nameController.value,
                  hintText: "Tên thiết bị",
                ),
                SizedBox(height: 20,),
                AppTextArea(
                  enable: false,
                  textEditingController: timeClockDeviceVM.macController.value,
                  hintText: "Địa chỉ MAC",
                ),
                SizedBox(height: 40,),
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
                  loading: timeClockDeviceVM.loading.value,
                  title:  "Cập nhật" ,
                  onPress: () {
                    timeClockDeviceVM.updateWorkShiftApi();
                    Get.back();
                  },
                ),
            ),
          ),
        ],

      ),
    );
  }
}
