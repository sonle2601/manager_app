import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_app/repository/manager_repository.dart';

import '../models/store_model.dart';
import '../repository/data_repository.dart';
import '../routes/route_name.dart';
import '../utils/utils.dart';
import '../utils/validation.dart';

class StoreViewModel extends GetxController{

  final _api = ManagerRepository();

  final name = TextEditingController().obs;
  final phoneNumber = TextEditingController().obs;
  final aptNumber = TextEditingController().obs;
  String? selectedCity, selectedDistrict, selectedWard;

  String? validateStore(
      String name,
      String phoneNumber,
      String aptNumber,
      String selectedCity,
      String selectedDistrict,
      String selectedWard,
      ) {
    if(!isNotEmpty(name)){
      return "Vui lòng nhập tên cửa hàng";
    }
    else if(!isNotEmpty(phoneNumber)){
      return "Vui lòng nhập số điện thoại";
    }
    else if(!isValidIDNumber(phoneNumber)){
      return  "Vui lòng nhập đúng định dạng số điện thoại";
    }
    else if(selectedWard?.isNotEmpty != true){
      return  "Vui lòng chọn địa chỉ hiện tại";
    }
    else if(!isNotEmpty(aptNumber)){
      return  "Vui lòng chọn địa chỉ chi tiết";
    }
  }

  @override
  void onInit() {
    super.onInit();
    getInforStore(); // Gọi phương thức khi màn hình được tạo
  }

  RxBool loading = false.obs;

  void storeApi() {
    loading.value = true;

    StoreModel store = StoreModel(
      ten: name.value.text.trim(),
      soDienThoai: phoneNumber.value.text.trim(),
      thanhPho: selectedCity.toString(),
      huyen: selectedDistrict.toString(),
      xa: selectedWard.toString(),
      chiTiet:aptNumber.value.text.trim(),
    );

    Map<String, dynamic> data = store.toJson();

    _api.postStore(data).then((value) {
      loading.value = false;
      Utils.snackBar("Success", "Create a successful store");
      Get.toNamed(RouteName.homeView);
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error.toString());
      Utils.snackBar("Loi", error.toString());
    });
  }


  void updateStore(){

  }

  Future<StoreModel> getInforStore() async {
    try {
      loading.value = true;
      StoreModel store = await _api.getStore(); // Gọi phương thức getStore() và chờ cho đến khi nó hoàn thành
      loading.value = false;
      return store; // Trả về đối tượng StoreModel
    } catch (error) {
      loading.value = false;
      print(error.toString());
      Utils.snackBar("Lỗi", error.toString());
      throw error; // Ném ra lỗi để được xử lý ở phía gọi
    }
  }


}
