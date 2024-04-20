import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_app/models/employee_model.dart';
import 'package:manage_app/models/information_model.dart';
import 'package:manage_app/models/user_model.dart';
import 'package:manage_app/repository/employee_repository.dart';

import '../../routes/route_name.dart';
import '../../utils/utils.dart';
import '../../utils/validation.dart';

class EmployeeViewModel extends GetxController{
  final _api = EmployeeRepository();


  var employee = <EmployeeModel>[].obs;
  var employeeAccept = <EmployeeModel>[].obs;
  var employeeAvailable = <EmployeeModel>[].obs;
  String? workShiftId;
  String? date;

  RxBool isUpdating = false.obs;
  RxBool status = false.obs;


  final nameController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final salariesController = TextEditingController().obs;
  final bankNumberController = TextEditingController().obs;
  String? selectedGender ;
  String? selectedBirthday ;
  String? selectedBank;
  String? imageFront;
  String? imageBack;
  String? address;
  String? startWork;
  String? startTime;
  int? parts ;


  final nameEditController = TextEditingController().obs;
  final phoneEditController = TextEditingController().obs;
  final accEditController = TextEditingController().obs;
  String? birdayEdit;
  String? genderEdit;
  String? bankEdit;
  String? addressEdit;
  int? idInfor;
  int? idEmployee;





  String? validate(
      String emailController,
      String nameController,
      String phoneController,
      int? parts,
      String? saraliesController,
      String? startTime,
      ) {
    if (!isNotEmpty(emailController)) {
      return "Vui lòng nhập email ứng viên";
    }else  if (!isNotEmpty(nameController)) {
      return "Vui lòng nhập tên ứng viên";
    }else  if (!isNotEmpty(phoneController)) {
      return "Vui lòng nhập số điện thoại ứng viên";
    }if (parts == null ) {
      return "Vui lòng chọn bộ phận làm việc";
    }
   else  if (!isNotEmpty(saraliesController.toString())) {
      return "Vui lòng nhập số lương";
    }else  if (!isNotEmpty(startTime.toString())) {
      return "Vui lòng chọn ngày vào làm";
    }
    return null;
  }


  String? validateInfo(
      String nameController,
      String phoneController,
      String birthdayController,
      String? address,
      String? gender,
      ) {
    if (!isNotEmpty(nameController)) {
      return "Vui lòng nhập tên nhân viên";
    }else  if (!isNotEmpty(phoneController)) {
      return "Vui lòng nhập số điện thoại nhân viên";
    }else  if (!isNotEmpty(birthdayController)) {
      return "Vui lòng chọn ngày sinh của nhân viên";
    }
    else  if (!isNotEmpty(address.toString())) {
      return "Vui lòng nhập địa chỉ";
    }else  if (!isNotEmpty(gender.toString())) {
      return "Vui chọn giới tính";
    }
    return null;
  }

  @override
  onInit(){
    getEmployee();
    getEmployeeAccept();
    super.onInit();
  }

  void resetTextField() {
    nameController.value.text = '';
    emailController.value.text = '';
    phoneController.value.text = '';
    salariesController.value.text = '';
     parts = null ;
    startTime = '';
  }


  RxBool loadData = false.obs;

  Future<void> getEmployee() async {
    try {
      loadData.value = false;
      List<EmployeeModel> employeeModel = await _api.getEmployee();
      employee.assignAll(employeeModel);
      loadData.value = true;
    } catch (error) {
      print(error.toString());
      Utils.snackBar("Lỗi", error.toString());
    }
  }

  Future<void> getEmployeeAvailable() async {
    try {
      loadData.value = false;
      List<EmployeeModel> employeeModel = await _api.getEmployeeAvailable(workShiftId!, date!);
      employeeAvailable.assignAll(employeeModel);

      loadData.value = true;
    } catch (error) {
      print(error.toString());
      Utils.snackBar("Lỗi", error.toString());
    }
  }

  Future<void> getEmployeeAccept() async {
    try {
      loadData.value = false;
      List<EmployeeModel> employeeModel = await _api.getEmployeeAccept();
      employeeAccept.assignAll(employeeModel);
      loadData.value = true;
    } catch (error) {
      print(error.toString());
      Utils.snackBar("Lỗi", error.toString());
    }
  }

  RxBool loading = false.obs;

  void addEmployee() {
    loading.value = true;
    String stringSalalies = salariesController.value.text;
    double? doubleSalalies = double.tryParse(stringSalalies);

    String employeeName = nameController.value.text;
    String employeeEmail = emailController.value.text;
    String employeePhone = phoneController.value.text;
    String birthdate = selectedBirthday.toString();
    String employeeGender = selectedGender.toString();
    String employeeAddress = address.toString();
    String employeeBank = selectedBank.toString();
    String bankNumber = bankNumberController.value.text;
    String frontPhoto = imageFront.toString();
    String backPhoto = imageBack.toString();
    String partId = parts.toString();
    String salaries = doubleSalalies.toString();
    String startWork = startTime.toString();

    Map<String, dynamic> data = {
      'employee_name': employeeName,
      'employee_email': employeeEmail,
      'employee_phone': employeePhone,
      'birthdate': birthdate,
      'employee_gender': employeeGender,
      'employee_address': employeeAddress,
      'employee_bank': employeeBank,
      'bank_number': bankNumber,
      'front_photo': frontPhoto,
      'back_photo': backPhoto,
      'part_id': partId,
      'salaries': salaries,
      'start_time': startWork,
    };

    _api.addEmployee(data).then((value) {
      loading.value = false;
      Utils.snackBar("Gửi lời mời", "Gửi lời mời làm việc thành công!");
      getEmployee();
      resetTextField();
      status.value = true;
    }).onError((error, stackTrace) {
      status.value = true;
      loading.value = false;
      switch (error){
        case 409 :
          Utils.snackBarError("Lỗi", "Đã có lời mời được gửi cho nhân viên");
        case 404 :
          Utils.snackBarError("Lỗi", "Email chưa được đăng kí tài khoản nhân viên");
      }
    });
  }

  void inforEmployee(EmployeeModel? employeeModel) {
    Get.toNamed(RouteName.employeeInfo, arguments: employeeModel); // Truyền dữ liệu vào arguments của Get.toNamed
  }

  void getInfoUpdate(EmployeeModel? employeeUpdate){
    var info = employeeUpdate!.information;
    idEmployee = employeeUpdate.id;
    idInfor = info!.id;
    nameEditController.value.text = info!.hoTen.toString();
    phoneEditController.value.text = info.soDienThoai.toString();
    accEditController.value.text = info.soTaiKhoan.toString();
    birdayEdit = info.namSinh.toString();
    genderEdit = info.gioiTinh.toString();
    bankEdit = info.nganHang.toString();
    addressEdit = info.diaChi.toString();
    Get.toNamed(RouteName.employeeInfoForm, arguments: employeeUpdate); // Truyền dữ liệu vào arguments của Get.toNamed
  }


  void updateInfoEmployee() {
    loading.value = true;

    InformationModel informationModel = InformationModel(
      id: idInfor,
      hoTen: nameEditController.value.text,
      soDienThoai: phoneEditController.value.text,
      namSinh: birdayEdit,
      gioiTinh: genderEdit,
      diaChi: addressEdit,
      nganHang: bankEdit,
      soTaiKhoan: accEditController.value.text
    );

    Map<String, dynamic> data = informationModel.toJson();
    _api.updateInfoEmployee(data).then((value) {
      loading.value = false;
      Utils.snackBar("Thông tin", "Cập nhật thông tin nhân viên thành công!");
      getEmployeeById();
      status.value = true;
    }).onError((error, stackTrace) {
      status.value = true;
      loading.value = false;
    });
  }


  Future<EmployeeModel?> getEmployeeById() async {
    try {
      loadData.value = false;
      EmployeeModel? employeeById = await _api.getEmployeeById(idEmployee!);
      return employeeById;
    } catch (error) {
      print(error.toString());
      Utils.snackBar("Lỗi", error.toString());
    }
  }

}