import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_app/models/parts_model.dart';
import 'package:manage_app/repository/data_repository.dart';
import 'package:manage_app/repository/get_data_reposotory.dart';

import '../../routes/route_name.dart';
import '../../utils/utils.dart';
import '../../utils/validation.dart';

class PartsViewModel extends GetxController{
  final _api = GetDataRepository();
  final _apiService = PostDataRepository();

  var parts = <PartsModel>[].obs;
  RxBool isUpdating = false.obs;
  RxBool switchValue = false.obs;
  RxBool loadData = false.obs;
  String textStatus = "Đang hoạt động";
  int? idPart ;



  @override
  void onInit() {
    getParts();
    super.onInit();
  }

  Future<void> getParts() async {
    try {
      loadData.value = false;
      List<PartsModel> partsModel = await _api.getParts();
      parts.assignAll(partsModel);
      loadData.value = true;
    } catch (error) {
      print(error.toString());
      Utils.snackBar("Lỗi", error.toString());
    }
  }
  void resetTextField() {
    nameController.value.text = '';
    descriptionController.value.text = '';
  }

  // bool hasData() {
  //   if(loadData.isTrue){
  //     return parts.isNotEmpty;
  //   }
  //   return false;
  // }


  final nameController = TextEditingController().obs;
  final descriptionController = TextEditingController().obs;


  void UpdatePart(PartsModel? part) {
    idPart = part!.id;
    isUpdating = true.obs;
    if (part != null) {
      nameController.value.text = part.partName ?? '';
      descriptionController.value.text = part.partDescription ?? '';
      switchValue.value = part.partStatus == 1;
      textStatus = switchValue.value ? "Đang hoạt động" : "Ngưng hoạt động";
    }
    Get.toNamed(RouteName.addParts);

  }

  void UpdatePartApi(){
    loading.value = true;

    PartsModel part = PartsModel(
      id: idPart,
      partName: nameController.value.text,
      partDescription: descriptionController.value.text,
      partStatus: switchValue.value ? 1 : 0,
    );

    Map<String, dynamic> data = part.toJson();

    _apiService.updateParts(data).then((value) {
      loading.value = false;
      Utils.snackBar("Bộ phận", "Cập nhật bộ phận thành công");
      getParts();
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error.toString());
      Utils.snackBar("Loi", error.toString());
    });
  }

  String? validate(String nameController) {
    if (!isNotEmpty(nameController)) {
      return "Vui lòng nhập tên bộ phận";
    }
    return null;
  }

  RxBool loading = false.obs;
  // RxBool switchValue = true.obs;

  void addApi() {
    loading.value = true;

    PartsModel part = PartsModel(
      partName: nameController.value.text,
      partDescription: descriptionController.value.text,
    );

    Map<String, dynamic> data = part.toJson();

    _apiService.addParts(data).then((value) {
      loading.value = false;
      Utils.snackBar("Bộ phận", "Thêm mới bộ phận thành công!");
      resetTextField();
      getParts();
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error.toString());
      Utils.snackBar("Loi", error.toString());
    });
  }

  void updatePartApi(String partName, String partDescription, bool switchValue) {
    loading.value = true;

    PartsModel part = PartsModel(
      partName: partName.trim(),
      partDescription: partDescription.trim(),
      partStatus: switchValue ? 1 : 0, // Chuyển đổi giá trị từ RxBool sang int
    );

    Map<String, dynamic> data = part.toJson();

    _apiService.addParts(data).then((value) {
      loading.value = false;
      Utils.snackBar("Parts", "Update parts successfully!");
      resetTextField();
      getParts();
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error.toString());
      Utils.snackBar("Loi", error.toString());
    });
  }
}
