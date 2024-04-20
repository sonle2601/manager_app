import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:manage_app/models/salary_model.dart';
import 'package:manage_app/repository/salary_repository.dart';

import '../../routes/route_name.dart';
import '../../utils/utils.dart';

class SalaryViewModel extends GetxController {
  final _api = SalaryRepository();
  RxString startDate = ''.obs;
  RxString endDate = ''.obs;

  late DateTime firstDayOfMonth;
  late DateTime lastDayOfMonth;

  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  var loadData = false.obs;
  var salary = SalaryModel().obs;

  String? employeeId;

  SalaryViewModel() {
    DateTime currentDate = DateTime.now();
    firstDayOfMonth = DateTime(currentDate.year, currentDate.month, 1);
    lastDayOfMonth = DateTime(currentDate.year, currentDate.month + 1, 0);
    startDate.value = dateFormat.format(firstDayOfMonth);
    endDate.value = dateFormat.format(lastDayOfMonth);
  }

  Future<void> getSalary() async {
    try {
      loadData.value = false;
      SalaryModel? salaryModel = await _api.getSalary(
          startDate.value, endDate.value, employeeId.toString());
      if (salaryModel != null) {
        salary.value = salaryModel;
        loadData.value = true;
        log(salary.value.employee!.information!.hoTen.toString());

      }
    } catch (error) {
      print(error.toString());
      Utils.snackBar("Lỗi", error.toString());
    }
  }


}
