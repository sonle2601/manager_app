import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_app/models/salary_bonus_model.dart';

import '../../repository/salary_bonus_repository.dart';
import '../../routes/route_name.dart';
import '../../utils/utils.dart';
import '../../utils/validation.dart';

class SalaryBonusViewModel extends GetxController{
  final _api = SaralyBonusRepository();

  var salaryBonus = <SalaryBonusModel>[].obs;
  RxBool loadData = false.obs;
  RxBool loading = false.obs;

  String? employeeId;

  final reasonController = TextEditingController().obs;
  final amountController = TextEditingController().obs;


  Future<void> getSalaryBonus() async {
    try {
      loadData.value = false;
      List<SalaryBonusModel> salaryBonusModel = await _api.getSaralyBonus();
      salaryBonus.assignAll(salaryBonusModel);
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
  void salaryBonusDetail(SalaryBonusModel? salaryBonus){
    Get.toNamed(RouteName.salaryBonusDetailScreen, arguments: salaryBonus);
  }



  void addSaralyBonus() {
    loading.value = true;
    SalaryBonusModel bonusModel = SalaryBonusModel(
        amount: amountController.value.text,
        employeeId: int.parse(employeeId.toString()),
        reason: reasonController.value.text
    );

    Map<String, dynamic> data = bonusModel.toJson();


    _api.addSalaryBonus(data).then((value) {
      loading.value = false;
      Utils.snackBar("Lương thưởng", "Đã thêm lương thưởng thành công!");
      getSalaryBonus();
    }).onError((error, stackTrace) {
      loading.value = false;
      Utils.snackBar("Lỗi", error.toString());
    });
  }

}