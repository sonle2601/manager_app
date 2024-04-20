import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manage_app/view_models/task_view_models/employee_view_model.dart';
import 'package:manage_app/view_models/task_view_models/parts_view_model.dart';
import 'package:manage_app/view_models/task_view_models/work_shift_view_model.dart';
import 'package:manage_app/widgets/can_cuoc_input.dart';
import 'package:manage_app/widgets/select_item/select_day.dart';
import 'package:manage_app/widgets/select_item/select_parts.dart';
import 'package:manage_app/widgets/select_item/select_salary_type.dart';

import '../../../utils/utils.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/app_text_area.dart';
import '../../../widgets/button_bottom.dart';
import '../../../widgets/select_item/select_address.dart';
import '../../../widgets/select_item/select_bank.dart';
import '../../../widgets/select_item/select_gender.dart';
import '../../../widgets/select_item/title_icon_select.dart';


class EmployeeInviteForm extends StatefulWidget {
  const EmployeeInviteForm({super.key});

  @override
  State<EmployeeInviteForm> createState() => _EmployeeInviteFormState();
}

class _EmployeeInviteFormState extends State<EmployeeInviteForm> {
  final nameController = TextEditingController();
  final textEditingController = TextEditingController();
  bool switchValue = true;
  var hour = 0;
  var minute = 0;
  var hourCurrent = 0;
  var minuteCurrent = 0;
  String selectedPartName = "Chọn bộ phận";
  String selectedSalaryType = "Chọn hình thức lương";
  String selectedDateTime = "Chọn ngày vào làm";
  String selectedBirdate = 'Chọn ngày sinh';
  String selectedGender = 'Chọn giới tính';
  String selectedBank = 'Chọn ngân hàng';



  @override
  Widget build(BuildContext context) {
    final employeeVM = Get.put(EmployeeViewModel());

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        elevation: 0,
        title: AppText(
              text: 'Thêm nhân viên mới',
              size: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () {
            employeeVM.resetTextField();
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 7,
                        offset: Offset(1, 10),
                        color: Colors.grey.withOpacity(0.2),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 10,),
                      Icon(Icons.mail, color: Colors.black54,),
                      SizedBox(width: 8,),
                      AppText(text: 'Gửi tới', color: Colors.black54,),
                      SizedBox(width: 10,),
                      Expanded(
                        child: TextFormField(
                          controller: employeeVM.emailController.value,
                          decoration: InputDecoration(
                            hintText: "Nhập vào email của ứng viên",
                            hintStyle: TextStyle(color: Colors.blue),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 1.0,
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 1.0,
                                color: Colors.white,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.only(left: 20, bottom: 15), // hoặc bất kỳ giá trị nào phù hợp
                  alignment: Alignment.centerLeft,
                  child: AppText(text: "THÔNG TIN CÁ NHÂN",  color: Colors.black87, fontWeight: FontWeight.bold,),
                ),
                AppTextArea(
                  textEditingController: employeeVM.nameController.value,
                  hintText: "Họ tên nhân viên",
                ),
                SizedBox(height: 20,),
                AppTextArea(
                  textEditingController: employeeVM.phoneController.value,
                  hintText: "Số điện thoại",
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    SelectDay.selectDate(context, (dateTime) {
                      setState(() {
                        employeeVM.selectedBirthday = dateTime.toString();
                        selectedBirdate = dateTime.toString();
                      });
                    });
                  },
                  child: TitleIconSelect(
                    icon: Icons.arrow_drop_down,
                    title: "Ngày sinh",
                    name: selectedBirdate.toString(),
                  ),
                ),
                SizedBox(height: 20,),
                SelectAddress(onLocationSelected: (onLocationSelected){
                  setState(() {
                    employeeVM.address = onLocationSelected.toString();
                  });
                }),
                SizedBox(height: 15,),
                GestureDetector(
                    onTap: (){
                      SelectGender.showSelectGender(context, (gender) {
                        employeeVM.selectedGender = gender.toString();
                        selectedGender = gender.toString();
                      });
                    },
                    child: TitleIconSelect(
                      name: selectedGender.toString(),
                      title: 'Giới tính',
                      icon: Icons.arrow_drop_down,
                    )
                ),

                SizedBox(height: 20,),

                GestureDetector(
                  onTap: (){
                    SelectBank.showSelectBank(context, (bankName){
                      setState(() {
                        employeeVM.selectedBank = bankName.toString();
                        selectedBank = bankName.toString();
                      });
                    });
                  },
                  child: TitleIconSelect(
                    title: 'Ngân hàng',
                    icon: Icons.account_balance,
                    name: selectedBank.toString(),),
                ),
                SizedBox(height: 20,),
                AppTextArea(
                  hintText: "Số tài khoản",
                  keyboardType: TextInputType.number,
                  textEditingController: employeeVM.bankNumberController.value,
                ),
                SizedBox(height: 20,),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.only(left: 20, bottom: 15), // hoặc bất kỳ giá trị nào phù hợp
                  alignment: Alignment.centerLeft,
                  child: AppText(
                    text: "THÔNG TIN XÁC THỰC",
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,),
                ),
                AnhCanCuoc(
                    text: 'Ảnh căn cước mặt trước',
                  onImageSelected: (String imageUrl) {
                    employeeVM.imageFront = imageUrl;
                  },
                ),
                AnhCanCuoc(
                    text: 'Ảnh căn cước mặt sau',
                  onImageSelected: (String imageUrl) {
                    employeeVM.imageBack = imageUrl;
                  },
                ),
                SizedBox(height: 15,),
                Container(
                  padding: EdgeInsets.only(left: 20, bottom: 15), // hoặc bất kỳ giá trị nào phù hợp
                  alignment: Alignment.centerLeft,
                  child: AppText(
                    text: "THÔNG TIN CÔNG VIỆC",
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20,),
                GestureDetector(
                    onTap: (){
                      SelectParts.showSelectParts(context, (idPart, namePart) {
                        setState(() {
                          employeeVM.parts = idPart;
                          selectedPartName = namePart;
                        });
                      },
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width, // Chiếm toàn bộ chiều rộng màn hình

                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(left: 22, right: 22),

                      decoration: BoxDecoration( // Tùy chỉnh màu sắc và viền của container
                        color: Colors.white, // Màu nền
                        borderRadius: BorderRadius.circular(10), // Bo tròn góc
                        // border: Border.all(color: Colors.black12), // Viền
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: Offset(1, 10),
                            color: Colors.grey.withOpacity(0.2),
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(text: selectedPartName),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                SizedBox(height: 20,),
                 // GestureDetector(
                 //    onTap: (){
                 //      SelectSalaryType.showSelectSalaryTypes(context, (type) {
                 //        setState(() {
                 //          selectedSalaryType = type;
                 //          employeeVM.saralyType = type;
                 //        });
                 //      },
                 //      );
                 //    },
                 //    child: Container(
                 //      width: MediaQuery.of(context).size.width, // Chiếm toàn bộ chiều rộng màn hình
                 //
                 //      padding: EdgeInsets.all(20),
                 //      margin: EdgeInsets.only(left: 22, right: 22),
                 //
                 //      decoration: BoxDecoration( // Tùy chỉnh màu sắc và viền của container
                 //        color: Colors.white, // Màu nền
                 //        borderRadius: BorderRadius.circular(10), // Bo tròn góc
                 //        boxShadow: [
                 //          BoxShadow(
                 //            blurRadius: 10,
                 //            spreadRadius: 7,
                 //            offset: Offset(1, 10),
                 //            color: Colors.grey.withOpacity(0.2),
                 //          )
                 //        ],
                 //      ),
                 //      child: Row(
                 //        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 //        children: [
                 //          AppText(text: selectedSalaryType),
                 //          Icon(Icons.arrow_drop_down),
                 //        ],
                 //      ),
                 //    ),
                 //  ),
                SizedBox(height: 20,),
                AppTextArea(
                    hintText: "Số tiền lương",
                  keyboardType: TextInputType.number,
                  textEditingController: employeeVM.salariesController.value,
                ),
                SizedBox(height: 20,),
                 GestureDetector(
                    onTap: (){
                      SelectDay.selectDate(context, (dateTime) {
                        setState(() {
                          selectedDateTime = dateTime.toString();
                          employeeVM.startTime = dateTime.toString();
                        });
                      },
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width, // Chiếm toàn bộ chiều rộng màn hình
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(left: 22, right: 22),

                      decoration: BoxDecoration( // Tùy chỉnh màu sắc và viền của container
                        color: Colors.white, // Màu nền
                        borderRadius: BorderRadius.circular(10), // Bo tròn góc
                        // border: Border.all(color: Colors.black12), // Viền
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: Offset(1, 10),
                            color: Colors.grey.withOpacity(0.2),
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(text: selectedDateTime),
                          Icon(Icons.calendar_today, color: Colors.blueAccent,),
                        ],
                      ),
                    ),
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
                  loading: employeeVM.loading.value,
                  title: 'Thêm nhân viên',
                  onPress: () {
                    String? validationError = employeeVM.validate(
                      employeeVM.emailController.value.text,
                      employeeVM.nameController.value.text,
                      employeeVM.phoneController.value.text,
                      employeeVM.parts,
                      employeeVM.salariesController.value.text,
                      employeeVM.startTime
                    );
                    if (validationError != null) {
                      Utils.snackBar("Lỗi", validationError.toString());
                    } else {
                      employeeVM.addEmployee();
                      if(employeeVM.status.value){
                        Get.back();
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
