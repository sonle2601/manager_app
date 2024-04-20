import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_app/models/salary_bonus_model.dart';
import 'package:manage_app/models/salary_penalty_model.dart';

import '../../repository/salary_bonus_repository.dart';
import '../../repository/salary_penalty_repository.dart';
import '../../routes/route_name.dart';
import '../../utils/utils.dart';
import '../../utils/validation.dart';

class SalaryPenaltyViewModel extends GetxController{
  final _api = SaralyPenaltyRepository();

  var salaryPenalty = <SalaryPenaltyModel>[].obs;
  RxBool loadData = false.obs;
  RxBool loading = false.obs;

  String? employeeId;

  final reasonController = TextEditingController().obs;
  final amountController = TextEditingController().obs;


  Future<void> getSalaryPenalty() async {
    try {
      loadData.value = false;
      List<SalaryPenaltyModel> salaryPenaltyModel = await _api.getSaralyPenalty();
      salaryPenalty.assignAll(salaryPenaltyModel);
      loadData.value = true;
    } catch (error) {
      print(error.toString());
      Utils.snackBar("Lỗi", error.toString());
    }
  }

  String? validate() {
    if (employeeId == null) {
      return "Vui lòng chọn nhân viên";
    }else  if (!isNotEmpty(amountController.value.text)) {
      return "Vui lòng nhập số tiền";
    }else  if (!isNotEmpty(reasonController.value.text)) {
      return "Vui lòng nhập lý do thưởng";
    }
    return null;
  }
  void salaryPenaltyDetail(SalaryPenaltyModel? salaryPenalty){
    Get.toNamed(RouteName.salaryPenaltyDetailScreen, arguments: salaryPenalty);
  }



  void addSalaryPenalty() {
    loading.value = true;
    SalaryPenaltyModel penaltyModel = SalaryPenaltyModel(
        amount: amountController.value.text,
        employeeId: int.parse(employeeId.toString()),
        reason: reasonController.value.text
    );

    Map<String, dynamic> data = penaltyModel.toJson();


    _api.addSalaryPenalty(data).then((value) {
      loading.value = false;
      Utils.snackBar("Lương phạt", "Đã thêm lương phạt thành công!");
      getSalaryPenalty();
    }).onError((error, stackTrace) {
      loading.value = false;
      Utils.snackBar("Lỗi", error.toString());
    });
  }

}