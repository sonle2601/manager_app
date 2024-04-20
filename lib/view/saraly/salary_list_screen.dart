import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_app/routes/route_name.dart';
import 'package:manage_app/view/task/employee/employee_accept_widget.dart';
import 'package:manage_app/view_models/task_view_models/attendance_view_model.dart';
import 'package:manage_app/view_models/task_view_models/employee_view_model.dart';
import 'package:manage_app/view_models/task_view_models/salary_view_model.dart';

import '../../../widgets/app_text.dart';

class SalaryListScreen extends StatefulWidget {
  const SalaryListScreen({super.key});

  @override
  State<SalaryListScreen> createState() => _SalaryListScreenState();
}

class _SalaryListScreenState extends State<SalaryListScreen> {
  final EmployeeViewModel employeeVM = Get.put(EmployeeViewModel());
  final salaryVM = Get.put(SalaryViewModel());

  @override
  Widget build(BuildContext context) {
    final employee = employeeVM.employeeAccept;
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.93),
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const AppText(
          text: "Danh sách luơng",
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
              child: AppText(text: "Không có nhân viên"), // Hiển thị thông báo khi không có dữ liệu
            )
                : ListView.builder(
              itemCount: employeeVM.employeeAccept.length,
              itemBuilder: (context, index) {
                var employee = employeeVM.employeeAccept[index];
                return EmployeeAcceptWidget(
                  onTap: (){
                    setState(() {
                      salaryVM.employeeId = employee.id.toString();
                    });
                    Get.toNamed(RouteName.salaryDetailScreen);
                  },
                  name: employee.information!.hoTen.toString(),
                  phone: employee.information!.soDienThoai.toString(),
                  email: employee.information!.email.toString(),
                  status: employee.employeeStatus.toString(),
                );
              },
            )
                : Center(
              child: CircularProgressIndicator(), // Hiển thị vòng loading
            );
          }
          ),
        ],
      ),
    );
  }
}
