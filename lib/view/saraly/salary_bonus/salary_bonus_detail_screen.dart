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

class SalaryBonusDetailScreen extends StatefulWidget {
  const SalaryBonusDetailScreen({super.key});

  @override
  State<SalaryBonusDetailScreen> createState() => _SalaryBonusDetailScreenState();
}

class _SalaryBonusDetailScreenState extends State<SalaryBonusDetailScreen> {

  final employeeVM = Get.put(EmployeeViewModel());
  final salaryBonusVM = Get.put(SalaryBonusViewModel());

  @override
  Widget build(BuildContext context) {
    var salaryBonus = Get.arguments as SalaryBonusModel?;
    // employeeVM.date = leave!.workSchedule!.date.toString();
    // employeeVM.workShiftId = leave!.workSchedule!.workShiftId.toString();
    // String? createdAt = leave!.createdAt; // Giả sử leave!.createdAt là một chuỗi thời gian trong định dạng chuỗi

    // DateTime parsedDate = DateTime.parse(createdAt!);
    //
    // String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);


    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const AppText(
          text: "Danh sách xin nghỉ",
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
      body: Container(
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
                      text: salaryBonus!.employee!.information!.hoTen.toString(),
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
                        child: AppText(text: salaryBonus!.employee!.information!.soDienThoai.toString(), size: 14, color: Colors.white,)
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
                text: "THÔNG TIN THƯỞNG",
              ),
            ),
            TitleTextWidget(title: 'Ngày', text: FormatUtils.formatDateString(salaryBonus.createdAt)),
            TitleTextWidget(title: 'Số tiền', text: FormatUtils.formatNumberWithCommas(salaryBonus.amount.toString())),
            TitleTextWidget(title: 'Lý do thưởng', text: salaryBonus.reason.toString()),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.black12,
              height: 1,
            ),
          ],
        ),
      ),
    );

  }
}
