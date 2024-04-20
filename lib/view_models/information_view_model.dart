import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_app/models/user_model.dart';

import '../models/information_model.dart';
import '../repository/data_repository.dart';
import '../repository/information_repository.dart';
import '../routes/route_name.dart';
import '../utils/utils.dart';
import '../utils/validation.dart';

class InformationViewModel extends GetxController{

  final _api = PostDataRepository();
  final _apiService = InformationRepository();


  var userInfor = UserModel().obs;


  final email = TextEditingController().obs;
  final name = TextEditingController().obs;
  final idNumber = TextEditingController().obs;
  final phoneNumber = TextEditingController().obs;
  final birthday = TextEditingController().obs;
  final accNumber  = TextEditingController().obs;

  final emailUserController = TextEditingController().obs;
  final nameUserController = TextEditingController().obs;
  final phoneUserController = TextEditingController().obs;
  final accUserController  = TextEditingController().obs;
  String? selectedUserBirthdate;
  String? selectedUserGender;
  String? selectedUserAddress;
  String? selectedUserBank;
  int? id;


  String? selectedGender;
  String? selectedAdress;
  String? selectedBank;
  String? frontImageUrl;
  String? backImageUrl;
  RxBool loadData = false.obs;

  final passwordController = TextEditingController().obs;
  final newPasswordController = TextEditingController().obs;
  final confirmPasswordController = TextEditingController().obs;


  String? validatePassword(){
    if(!isNotEmpty(passwordController.value.text)){
      return "Vui lòng nhập mât khẩu hiện tại";
    }else if(!isNotEmpty(newPasswordController.value.text)){
      return "Vui lòng nhập mật khẩu mới";
    }else if(newPasswordController.value.text != confirmPasswordController.value.text){
      return "Mật khẩu không trùng nhau";
    }
  }

  String? validateInformation(
      String email,
      String name,
      String idNumber,
      String phoneNumber,
      String birthday,
      String selectedGender,
      String selectedAddress,
      String frontImageUrl,
      String backImageUrl,
      ) {
    if (!isNotEmpty(email)){
      return "Vui lòng nhập email";
    }
    else if(!isValidEmail(email)){
      return "Vui lòng nhập đúng định dạng emal";
    }
    else if(!isNotEmpty(name)){
      return "Vui lòng nhập họ tên";
    }
    else if(!isNotEmpty(idNumber)){
      return "Vui lòng nhập số căn cước";
    }
    else if(!isValidIDNumber(idNumber)){
      return  "Vui lòng nhập đúng định dạng số căn cước";
    }
    else if(!isNotEmpty(phoneNumber)){
      return "Vui lòng nhập số điện thoại";
    }
    else if(!isValidIDNumber(phoneNumber)){
      return  "Vui lòng nhập đúng định dạng số điện thoại";
    }
    else if(!isNotEmpty(birthday)){
      return  "Vui lòng nhập ngày sinh";
    }
    else if(selectedGender?.isNotEmpty != true){
      return "Vui lòng chọn giới tính";
    }
    else if(!isNotEmpty(selectedAddress)){
      return  "Vui lòng chọn địa chỉ";
    }
    else if(frontImageUrl?.isNotEmpty != true){
      return  "Vui lòng thêm ảnh căn cước mặt trước";
    }
    else if(backImageUrl?.isNotEmpty != true){
      return  "Vui lòng thêm ảnh căn cước mặt sau";
    }
  }

  RxBool loading = false.obs;


  void informationApi() {
    loading.value = true;

    InformationModel infor = InformationModel(
      email: email.value.text,
      hoTen: name.value.text,
      soCmnd: idNumber.value.text,
      soDienThoai: phoneNumber.value.text,
      namSinh: birthday.value.text,
      gioiTinh: selectedGender.toString(),
      diaChi: selectedAdress,
      nganHang: selectedBank.toString(),
      soTaiKhoan: accNumber.value.text,
      anhMatSau: backImageUrl.toString(),
      anhMatTruoc: frontImageUrl.toString()
    );

    Map<String, dynamic> data = infor.toJson();


    _api.postInformation(data).then((value) {
      loading.value = false;
      Utils.snackBar("Thông tin", "Cập nhật thông tin thành công!");
      Get.toNamed(RouteName.homeView);
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error.toString());
      Utils.snackBar("Loi", error.toString());
    });
  }

  // Future<void> getInfo() async {
  //   try {
  //     loadData.value = false;
  //     List<InformationModel> employeeModel = await _api.();
  //     employee.assignAll(employeeModel);
  //     loadData.value = true;
  //   } catch (error) {
  //     print(error.toString());
  //     Utils.snackBar("Lỗi", error.toString());
  //   }
  // }

  String? validateInforUser(){
    if(!isNotEmpty(phoneUserController.value.text)){
      return 'Vui lòng nhập số điện thoại';
    }else if(selectedUserBirthdate == 'Chọn ngày sinh'){
      return 'Vui lòng chọn ngày sinh';
    }else if(selectedUserAddress == null){
      return 'Vui lòng nhập địa chỉ';
    }else if(selectedUserGender == null){
      return 'Vui lòng chọn giới tính';
    }
  }

  String? checkTextField(String? info){
    if(info == '-'){
      return '';
    }else{
      return info;
    }
  }

  String? checkBirdate(String? info){
    if(info == '-'){
      return 'Chọn ngày sinh';
    }else{
      return info;
    }
  }

  String? checkGender(String? info){
    if(info == '-'){
      return 'Chọn giới tính';
    }else{
      return info;
    }
  }

  String? checkBank(String? info){
    if(info == '-'){
      return 'Chọn ngân hàng';
    }else{
      return info;
    }
  }


  void updateInfoScreen(UserModel? userModel){
    id = userModel!.information!.id;
    emailUserController.value.text = userModel!.information!.email.toString();
    nameUserController.value.text = userModel!.information!.hoTen.toString();
    phoneUserController.value.text = checkTextField(userModel!.information!.soDienThoai.toString())!;
    accUserController.value.text = checkTextField(userModel!.information!.soTaiKhoan.toString())!;
    selectedUserBirthdate = checkBirdate(userModel!.information!.namSinh.toString());
    selectedUserAddress = userModel!.information!.diaChi.toString();
    selectedUserBank = checkBank(userModel!.information!.nganHang.toString());
    selectedUserGender = checkGender(userModel!.information!.gioiTinh.toString());
    Get.toNamed(RouteName.infoUserScreen);
  }

  void updateInfoUser(){
    loading.value = true;

    InformationModel infor = InformationModel(
        id: id,
        soDienThoai: phoneUserController.value.text,
        namSinh: selectedUserBirthdate,
        gioiTinh: selectedUserGender,
        diaChi: selectedUserAddress,
        nganHang: selectedUserBank,
        soTaiKhoan: accUserController.value.text,
    );

    Map<String, dynamic> data = infor.toJson();


    _apiService.updateInfoPersonal(data).then((value) {
      loading.value = false;
      Utils.snackBar("Thông tin", "Cập nhật thông tin thành công!");
      getInforUser();
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error.toString());
      Utils.snackBar("Loi", error.toString());
    });
  }

  void changePassword(){
    loading.value = true;
    Map<String, dynamic> data = {
      'current_password': passwordController.value.text,
      'new_password': newPasswordController.value.text
    };

    _apiService.changePassword(data).then((value) {
      loading.value = false;
      Utils.snackBar("Đổi mật khẩu", "Đổi mật khẩu thành công!");
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error.toString());
      Utils.snackBar("Loi", error.toString());
    });
  }

  Future<void> getInforUser() async {
    try {
      loadData.value = false;
      UserModel? userModel = await _apiService.getUserInfo();
      userInfor.value = userModel!;
      loadData.value = true;
    } catch (error) {
      print(error.toString());
      Utils.snackBar("Lỗi", error.toString());
    }
  }


}