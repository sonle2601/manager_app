import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:manage_app/models/salary_bonus_model.dart';
import 'package:manage_app/utils/format_util.dart';
import 'package:manage_app/view/approval/leave/title_text_widget.dart';
import 'package:manage_app/view_models/task_view_models/leave_view_model.dart';
import 'package:manage_app/view_models/task_view_models/salary_bonus_view_model.dart';

import '../../../models/leave_model.dart';
import '../../../view_models/task_view_models/employee_view_model.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/select_item/select_employee_available.dart';
import '../../../widgets/select_item/title_icon_select.dart';
import '../../models/salary_model.dart';
import '../../view_models/task_view_models/salary_view_model.dart';

class SalaryDetailScreen extends StatefulWidget {
  const SalaryDetailScreen({super.key});

  @override
  State<SalaryDetailScreen> createState() => _SalaryDetailScreenState();
}

class _SalaryDetailScreenState extends State<SalaryDetailScreen> {

  final employeeVM = Get.put(EmployeeViewModel());
  final salaryVM = Get.put(SalaryViewModel());

  @override
  Widget build(BuildContext context) {
      salaryVM.getSalary();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const AppText(
          text: "Chi tiết lương",
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
      body: Obx(() {
        if(salaryVM.loadData.value){
          var salaryModel = salaryVM.salary.value;
          return Container(
            margin: EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black12, // Màu sắc của đường viền
                            width: 2, // Độ dày của đường viền
                          ),
                        ),
                        child: Image.asset(
                          'assets/images/user.png',
                          scale: 13,// Đảm bảo hình ảnh được căn giữa và cắt theo hình tròn
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: salaryModel.employee!.information!.hoTen.toString(),
                          size: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,),
                        SizedBox(height: 5,),
                        Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: AppText(text: salaryModel!.employee!.information!.soDienThoai.toString(), size: 14, color: Colors.white,)
                        )
                      ],
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.only(top: 15),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black12,
                  child: AppText(
                    text: "THÔNG TIN LƯƠNG",
                  ),
                ),
                TitleTextWidget(title: 'Lương theo giờ', text: FormatUtils.formatNumberWithCommas(salaryModel.salaryHour.toString())),
                TitleTextWidget(title: 'Số giờ đã làm', text:FormatUtils.convertMinutesToHoursAndMinutes(salaryModel.totalMinutes) ),
                TitleTextWidget(title: 'Tổng thưởng', text: FormatUtils.formatNumberWithCommas(salaryModel.totalSalaryBonus.toString())),
                TitleTextWidget(title: 'Tổng phạt', text: FormatUtils.formatNumberWithCommas(salaryModel.totalSalaryPenalty.toString())),
                TitleTextWidget(title: 'Thực nhận', text: FormatUtils.formatNumberWithCommas(salaryModel.totalSalary.toString())),

                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black12,
                  height: 1,
                ),
              ],
            ),
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      })
    );

  }
}
