import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_app/view/approval/leave/title_text_widget.dart';
import 'package:manage_app/view/saraly/salary_bonus/select_employee_accept.dart';
import 'package:manage_app/view_models/task_view_models/salary_bonus_view_model.dart';
import 'package:manage_app/widgets/app_text_area.dart';
import 'package:manage_app/widgets/select_item/select_employee.dart';
import 'package:manage_app/widgets/select_item/title_icon_select.dart';

import '../../../utils/utils.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/button_bottom.dart';
import '../../../widgets/select_item/select_employee_available.dart';

class SalaryBonusAddScreen extends StatefulWidget {
  const SalaryBonusAddScreen({super.key});

  @override
  State<SalaryBonusAddScreen> createState() => _SalaryBonusAddScreenState();
}

class _SalaryBonusAddScreenState extends State<SalaryBonusAddScreen> {


  @override
  Widget build(BuildContext context) {
    final salaryBonusVM = Get.put(SalaryBonusViewModel());


    String selectEmployee = 'Chọn nhân viên';
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const AppText(
          text: "Thêm lương thưởng",
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
        child: Column(
          children: [
            SizedBox(height: 10,),
            GestureDetector(
                onTap: (){
                  SelectEmployeeAccept.showSelectEmployee(context, (selectedEmployeeId, nameEmployee) {
                    setState(() {
                      selectEmployee =nameEmployee.toString();
                      salaryBonusVM.employeeId = selectedEmployeeId.toString();
                    });
                  });
                },
                child: TitleIconSelect(title: 'Nhân viên', icon: Icons.person, name: selectEmployee.toString())

            ),
            SizedBox(height: 10,),
            AppTextArea(
              textEditingController: salaryBonusVM.amountController.value,
              hintText: "Số tiền",
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10,),
            AppTextArea(
              textEditingController: salaryBonusVM.reasonController.value,
              hintText: "Lý do",
              maxLines: 3,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() =>
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ButtonButtom(
              loading: salaryBonusVM.loading.value,
              title: "Thêm mới",
              onPress: () {
                String? validationError = salaryBonusVM.validate();
                if (validationError != null) {
                  Utils.snackBar("Lỗi", validationError.toString());
                } else {
                  salaryBonusVM.addSaralyBonus();
                  Get.back();
                }
              },
            ),
          ),
      ),
    );
  }
}
