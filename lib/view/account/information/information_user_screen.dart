import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_app/view_models/information_view_model.dart';
import '../../../models/employee_model.dart';
import '../../../utils/utils.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/app_text_area.dart';
import '../../../widgets/button_bottom.dart';
import '../../../widgets/select_item/select_address.dart';
import '../../../widgets/select_item/select_bank.dart';
import '../../../widgets/select_item/select_day.dart';
import '../../../widgets/select_item/select_gender.dart';
import '../../../widgets/select_item/title_icon_select.dart';

class InformationUserScreen extends StatefulWidget {
  const InformationUserScreen({super.key});

  @override
  State<InformationUserScreen> createState() => _InformationUserScreenState();
}

class _InformationUserScreenState extends State<InformationUserScreen> {
  var employee = Get.arguments as EmployeeModel?;

  final textController = TextEditingController();
  var hour = 0;
  var minute = 0;
  var hourCurrent = 0;
  var minuteCurrent = 0;

  @override
  Widget build(BuildContext context) {
    final infoVM = Get.put(InformationViewModel());
    bool? checkAddress(){
      if(infoVM.selectedUserAddress == '-'){
        return true;
      }else{
        return false;
      }
    }

    // String selectedBirthday = employeeVM.birdayEdit.toString();
    // String selectedGender = employeeVM.genderEdit.toString();
    // String selectedBank = employeeVM.bankEdit.toString();
    // String selectedAddress = employeeVM.addressEdit.toString();

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
                Container(
                  padding: EdgeInsets.only(left: 20, bottom: 15), // hoặc bất kỳ giá trị nào phù hợp
                  alignment: Alignment.centerLeft,
                  child: AppText(text: "THÔNG TIN CÁ NHÂN",  color: Colors.black87, fontWeight: FontWeight.bold,),
                ),
                SizedBox(height: 10,),
                AppTextArea(
                  textEditingController: infoVM.emailUserController.value,
                  hintText: "Email",
                  enable: false,
                ),
                SizedBox(height: 20,),
                AppTextArea(
                  textEditingController: infoVM.nameUserController.value,
                  hintText: "Họ và tên ",
                  enable: false,
                ),
                SizedBox(height: 20,),
                AppTextArea(
                  textEditingController: infoVM.phoneUserController.value,
                  hintText: "Số điện thoại",
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    SelectDay.selectDate(context, (dateTime) {
                      setState(() {
                        infoVM.selectedUserBirthdate = dateTime.toString();
                      });
                    });
                  },
                  child: TitleIconSelect(
                    icon: Icons.arrow_drop_down,
                    title: "Ngày sinh",
                    name: infoVM.selectedUserBirthdate.toString(),
                  ),
                ),
                SizedBox(height: 20,),
                if(infoVM.selectedUserAddress == '-')
                  SelectAddress(
                    onLocationSelected: (onLocationSelected){
                      setState(() {
                        infoVM.selectedUserAddress = onLocationSelected.toString();
                      });
                    },
                  )
                else
                  SelectAddress(
                    addressSelected: infoVM.selectedUserAddress,
                    onLocationSelected: (onLocationSelected){
                      setState(() {
                        infoVM.selectedUserAddress = onLocationSelected.toString();
                      });
                    },
                  ),
                SizedBox(height: 15,),

                GestureDetector(
                    onTap: (){
                      SelectGender.showSelectGender(context, (gender) {
                        infoVM.selectedUserGender = gender.toString();
                      });
                    },
                    child: TitleIconSelect(
                      name: infoVM.selectedUserGender.toString(),
                      title: 'Giới tính',
                      icon: Icons.arrow_drop_down,
                    )
                ),

                SizedBox(height: 20,),

                GestureDetector(
                  onTap: (){
                    SelectBank.showSelectBank(context, (bankName){
                      setState(() {
                        infoVM.selectedUserBank = bankName.toString();
                      });
                    });
                  },
                  child: TitleIconSelect(title: 'Ngân hàng', icon: Icons.account_balance, name: infoVM.selectedUserBank.toString(),),
                ),
                SizedBox(height: 20,),
                AppTextArea(
                  hintText: "Số tài khoản",
                  keyboardType: TextInputType.number,
                  textEditingController: infoVM.accUserController.value,
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
                  loading: infoVM.loading.value,
                  title: 'Cập nhật', onPress: () {
                    String? error = infoVM.validateInforUser();
                    if(error != null){
                      Utils.snackBarError('Lỗi', error);
                    }else{
                      infoVM.updateInfoUser();
                      Get.back();
                    }

                    // String? validationError = employeeVM.validateInfo();
                    // if (validationError != null) {
                    //   Utils.snackBar("Lỗi", validationError.toString());
                    // } else {
                    //   employeeVM.updateInfoEmployee();
                    //   if(employeeVM.loadData.value){
                    //     log(employeeVM.employeeInfo.value.information!.soDienThoai.toString());
                    //     Get.back(result: employeeVM.employeeInfo.value);
                    //   }
                    // }
                },
                ),
            ),
          ),
        ],

      ),
    );
  }
}
