import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_app/widgets/select_item/select_address.dart';
import 'package:manage_app/widgets/select_item/select_bank.dart';
import 'package:manage_app/widgets/select_item/select_gender.dart';
import 'package:manage_app/widgets/select_item/title_icon_select.dart';

import '../../../models/employee_model.dart';
import '../../../utils/utils.dart';
import '../../../view_models/task_view_models/employee_view_model.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/app_text_area.dart';
import '../../../widgets/button_bottom.dart';
import '../../../widgets/select_item/select_day.dart';

class EmployeeInfoForm extends StatefulWidget {
  const EmployeeInfoForm({super.key});

  @override
  State<EmployeeInfoForm> createState() => _EmployeeInfoFormState();
}

class _EmployeeInfoFormState extends State<EmployeeInfoForm> {
  var employee = Get.arguments as EmployeeModel?;

  final textController = TextEditingController();
  var hour = 0;
  var minute = 0;
  var hourCurrent = 0;
  var minuteCurrent = 0;

  @override
  Widget build(BuildContext context) {
    final employeeVM = Get.put(EmployeeViewModel());

    String selectedBirthday = employeeVM.birdayEdit.toString();
    String selectedGender = employeeVM.genderEdit.toString();
    String selectedBank = employeeVM.bankEdit.toString();
    String selectedAddress = employeeVM.addressEdit.toString();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        elevation: 0,
        title: AppText(
              text: "Cập nhật thông tin cá nhân",
              size: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () {
            // employeeVM.inforEmployee(employee);
            // Navigator.of(context).pop();
            Get.back(result: employee);
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
                SizedBox(height: 20,),
                AppTextArea(
                  textEditingController: employeeVM.nameEditController.value,
                  hintText: "Họ và tên ",
                ),
                SizedBox(height: 20,),
                AppTextArea(
                  textEditingController: employeeVM.phoneEditController.value,
                  hintText: "Số điện thoại",
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    SelectDay.selectDate(context, (dateTime) {
                      setState(() {
                        employeeVM.birdayEdit = dateTime.toString();
                      });
                    });
                  },
                  child: TitleIconSelect(
                    icon: Icons.arrow_drop_down,
                    title: "Ngày sinh",
                    name: selectedBirthday,
                  ),
                ),
                SizedBox(height: 20,),
                SelectAddress(addressSelected: selectedAddress,onLocationSelected: (onLocationSelected){
                  setState(() {
                    employeeVM.addressEdit = onLocationSelected.toString();
                  });
                }),
                SizedBox(height: 15,),
                GestureDetector(
                  onTap: (){
                    SelectGender.showSelectGender(context, (gender) {
                      employeeVM.genderEdit = gender.toString();
                    });
                  },
                  child: TitleIconSelect(
                    name: selectedGender,
                    title: 'Giới tính',
                    icon: Icons.arrow_drop_down,
                  )
                ),

                SizedBox(height: 20,),
                // SelectAddress(onLocationSelected: (address){
                //
                // }),

                GestureDetector(
                  onTap: (){
                    SelectBank.showSelectBank(context, (bankName){
                      setState(() {
                        employeeVM.bankEdit = bankName.toString();
                      });
                    });
                  },
                  child: TitleIconSelect(title: 'Ngân hàng', icon: Icons.account_balance, name: selectedBank,),
                ),
                SizedBox(height: 20,),
                AppTextArea(
                  hintText: "Số tài khoản",
                  keyboardType: TextInputType.number,
                  textEditingController: employeeVM.accEditController.value,
                ),
                SizedBox(height: 20,),
                SizedBox(height: 150,),
              ],
            ),
          ),

          Positioned(
            bottom: 20,
            left: 10,
            right: 10,
            child: Obx(() =>
                ButtonButtom(
                  loading: employeeVM.loading.value,
                  title: 'Cập nhật',
                  onPress: () {
                    String? validationError = employeeVM.validateInfo(
                        employeeVM.nameEditController.value.text,
                        employeeVM.phoneEditController.value.text,
                        employeeVM.birdayEdit.toString(),
                        employeeVM.addressEdit,
                        employeeVM.genderEdit
                    );
                    if (validationError != null) {
                      Utils.snackBar("Lỗi", validationError.toString());
                    } else {
                      employeeVM.updateInfoEmployee();
                      if(employeeVM.status.value){
                        Get.back(result: employeeVM.getEmployeeById);
                      }
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
