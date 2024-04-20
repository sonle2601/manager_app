import 'dart:developer';

import 'package:manage_app/models/salary_model.dart';

import '../data/network/network_api_services.dart';
import '../utils/app_url.dart';

class SalaryRepository{
  final _apiService = NetworkApiServices();

  Future<SalaryModel?> getSalary(String startDate, String endDate, String employeeId) async {

    dynamic response = await _apiService.getApi(AppUrl.salary(startDate, endDate, employeeId));
    SalaryModel salaryModel = SalaryModel.fromJson(response);
    return salaryModel;
  }

}