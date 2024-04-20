import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_app/models/work_shift_model.dart';
import 'package:manage_app/repository/work_shift_repository.dart';
import 'package:manage_app/utils/utils.dart';

import '../../routes/route_name.dart';
import '../../utils/validation.dart';

class WorkShiftViewModel extends GetxController{
  final _api = WorkShiftRepository();

  var workShifts = <WorkShiftModel>[].obs;
  RxBool isUpdating = false.obs;
  RxBool switchValue = false.obs;
  RxBool loading = false.obs;
  String textStatus = "Đang hoạt động";
  int? idWorkShift ;





  @override
  void onInit() {
    getWorkShift();
    super.onInit();
  }

  RxBool loadData = false.obs;



  Future<void> getWorkShift() async {
    try {
      loadData.value = false;
      List<WorkShiftModel> workShiftsModel = await _api.getWorkShift();
      workShifts.assignAll(workShiftsModel);
      loadData.value = true;
    } catch (error) {
      print(error.toString());
      Utils.snackBar("Lỗi", error.toString());
    }
  }

  void resetTextField() {
    nameController.value.text = '';
    startTimeController.value.text = '';
    endTimeController.value.text = '';
  }





  void UpdateWorkShift(WorkShiftModel? workShift) {
    idWorkShift = workShift!.id;
    isUpdating = true.obs;
    if (workShift != null) {
      nameController.value.text = workShift.name ?? '';
      startTimeController.value.text = workShift.startTime ?? '';
      endTimeController.value.text = workShift.endTime ?? '';
      switchValue.value = workShift.status == 1;
      textStatus = switchValue.value ? "Đang hoạt động" : "Ngưng hoạt động";
    }
    Get.toNamed(RouteName.workShiftWidget);

  }

  final nameController = TextEditingController().obs;
  final startTimeController = TextEditingController().obs;
  final endTimeController = TextEditingController().obs;
  String? validate(String nameController, String startTimeController, String endTimeController) {
    if (!isNotEmpty(nameController)) {
      return "Vui lòng nhập tên ca làm việc";
    }else  if (!isNotEmpty(startTimeController)) {
      return "Vui lòng nhập thời gian bắt đầu";
    }else  if (!isNotEmpty(endTimeController)) {
      return "Vui lòng nhập thời gian kết thúc";
    }
    return null;
  }


  void addWorkShiftApi() {
    loading.value = true;

    WorkShiftModel workShift = WorkShiftModel(
      name: nameController.value.text,
      startTime: startTimeController.value.text,
      endTime: endTimeController.value.text
    );

    Map<String, dynamic> data = workShift.toJson();

    _api.addWorkShift(data).then((value) {
      loading.value = false;
      Utils.snackBar("Ca làm việc", "Thêm mới ca làm việc thành công!");
      resetTextField();
      getWorkShift();
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error.toString());
      Utils.snackBar("Loi", error.toString());
    });
  }

  void UpdateWorkShiftApi(){
    loading.value = true;

    WorkShiftModel workShift = WorkShiftModel(
      id: idWorkShift,
      name: nameController.value.text,
      startTime: startTimeController.value.text,
      endTime: endTimeController.value.text,
      status: switchValue.value ? 1 : 0,
    );

    Map<String, dynamic> data = workShift.toJson();

    _api.updateWorkShift(data).then((value) {
      loading.value = false;
      Utils.snackBar("Ca làm việc", "Cập nhật ca làm việc thành công");
      resetTextField();
      getWorkShift();
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error.toString());
      Utils.snackBar("Loi", error.toString());
    });
  }


}