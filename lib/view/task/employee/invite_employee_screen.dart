import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_app/view_models/task_view_models/employee_view_model.dart';
import 'package:manage_app/widgets/task/employee_widget.dart';

import '../../../routes/route_name.dart';
import '../../../widgets/app_text.dart';


class EmployeeScreen extends StatelessWidget {
   EmployeeScreen({super.key});

  final EmployeeViewModel employeeVM = Get.put(EmployeeViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.93),
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const AppText(
          text: "Lời mời đã gửi",
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
          return employeeVM.loadData.value
               ? employeeVM.employee.isEmpty
               ? Center(
             child: AppText(text: "Không có nhân viên được mời"), // Hiển thị thông báo khi không có dữ liệu
           )
               : ListView.builder(
             itemCount: employeeVM.employee.length,
             itemBuilder: (context, index) {
               var employee = employeeVM.employee[index];
               return EmployeeWidget(
                 name: employee.information!.hoTen.toString(),
                 phone: employee.information!.soDienThoai.toString(),
                 email: employee.information!.email.toString(),
               );
             },
           )
               : Center(
            child: CircularProgressIndicator(), // Hiển thị vòng loading
            );
          }
          ),
          Positioned(
            bottom: 30,
            right: 30,
            child: FloatingActionButton(
              onPressed: () {
                employeeVM.isUpdating = false.obs;
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
  Get.toNamed(RouteName.inviteEmployeeForm);
}