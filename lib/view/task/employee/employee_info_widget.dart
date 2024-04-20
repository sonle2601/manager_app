import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:manage_app/routes/route_name.dart';
import 'package:manage_app/widgets/app_text.dart';
import 'package:manage_app/widgets/text_row_widget.dart';

import '../../../models/employee_model.dart';
import '../../../view_models/task_view_models/employee_view_model.dart';

class EmployeeInfoWidget extends StatelessWidget {
   EmployeeInfoWidget({super.key});
  final EmployeeViewModel employeeVM = Get.put(EmployeeViewModel());


  @override
  Widget build(BuildContext context) {
    var employee = Get.arguments as EmployeeModel?;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body:  Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 2, color: Colors.black26),
                  ),
                  child: Image.asset(
                    'assets/images/employee.png',
                    scale: 11,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(text: employee!.user!.name.toString(), fontWeight: FontWeight.bold,size: 20,),
                    SizedBox(height: 10,),
                    AppText(text: "Bộ phận ${employee!.part!.partName.toString()}", size: 15, color: Colors.black54,)
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            bottom: 0,
            child:SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.black12,
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  height: 350,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.grey,
                      width: .5,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(text: "Thông tin cá nhân", fontWeight: FontWeight.bold,),
                          GestureDetector(
                            onTap: (){
                              employeeVM.getInfoUpdate(employee);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              height: 25,
                              width: 25,
                              margin: EdgeInsets.only(right: 20),
                              child: Icon(Icons.edit, size: 15,),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      TextRowWidget(title: 'Họ và tên', info: employee.information!.hoTen.toString()),
                      TextRowWidget(title: 'Email', info: employee.information!.email.toString()),
                      TextRowWidget(title: 'Số điện thoại', info: employee.information!.soDienThoai.toString()),
                      TextRowWidget(title: 'Ngày sinh', info: employee.information!.namSinh.toString()),
                      TextRowWidget(title: 'Giới tính', info: employee.information!.gioiTinh.toString()),
                      TextRowWidget(
                        maxLine: 2,
                          title: 'Địa chỉ',
                          info: '${employee.information!.diaChi.toString()}'
                              ),
                      TextRowWidget(maxLine: 2,title: 'Tài khoản ngân hàng', info: '${employee.information?.soTaiKhoan.toString() ?? ""
                          } \n${employee.information?.nganHang.toString() ?? ""}'),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  height: 220,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.grey,
                      width: .5,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(text: "Thông tin công việc", fontWeight: FontWeight.bold,),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: 25,
                            width: 25,
                            margin: EdgeInsets.only(right: 20),
                            child: Icon(Icons.edit, size: 15,),
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      TextRowWidget(title: 'Bộ phận', info: employee.part!.partName.toString()),
                      TextRowWidget(title: 'Mức lương', info: formatSalary(employee.salaries.toString())),
                      TextRowWidget(title: 'Ngày gia nhập', info: employee.startTime.toString()),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  height: 163,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.grey,
                      width: .5,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(text: "Thông tin xác thực", fontWeight: FontWeight.bold,),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: 25,
                            width: 25,
                            margin: EdgeInsets.only(right: 20),
                            child: Icon(Icons.edit, size: 15,),
                          )
                        ],
                      ),
                      SizedBox(height: 15,),
                     Row(
                       children: [
                         Container(
                           child: Image.network(
                             employee.information!.anhMatTruoc.toString(),
                             fit: BoxFit.cover,
                           ),
                           height: 80,
                           width: 130,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(30),
                           ),
                         ),
                         SizedBox(width: 40,),
                         Container(
                           child: Image.network(
                             employee.information!.anhMatSau.toString(),
                             fit: BoxFit.cover,
                           ),
                           height: 80,
                           width: 130,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(30),
                           ),
                         )
                       ],
                     )
                    ],
                  ),
                ),
              ],
            ),
          ),
          )
        ],
      ),



    );
  }
}
String formatSalary(String salary) {
  double salaryDouble = double.tryParse(salary) ?? 0.0;
  final formatter = NumberFormat('#,###');
  return formatter.format(salaryDouble);
}
