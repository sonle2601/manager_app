import 'package:manage_app/models/employee_model.dart';

import '../data/network/network_api_services.dart';
import '../utils/app_url.dart';

class EmployeeRepository{
  final _apiService = NetworkApiServices();


  Future<List<EmployeeModel>> getEmployee() async {
    dynamic response = await _apiService.getApi(AppUrl.employee);

    if (response != null && response is List) {
      List<EmployeeModel> employeeList = List<EmployeeModel>.from(
        response.map((employee) => EmployeeModel.fromJson(employee)).toList(),
      );
      return employeeList;
    }
    else {
      return [];
    }
  }

  Future<List<EmployeeModel>> getEmployeeAccept() async {
    dynamic response = await _apiService.getApi(AppUrl.employeeAccept);

    if (response != null && response is List) {
      List<EmployeeModel> employeeList = List<EmployeeModel>.from(
        response.map((employee) => EmployeeModel.fromJson(employee)).toList(),
      );
      return employeeList;
    }
    else {
      return [];
    }
  }

  Future<dynamic> addEmployee(var data) async{
    dynamic response = await _apiService.postApi(data, AppUrl.employee);
    return response;
  }

  Future<dynamic> updateInfoEmployee(var data) async{
    dynamic response = await _apiService.putApi(data, AppUrl.infomation);
    return response;
  }


  Future<EmployeeModel?> getEmployeeById(int id) async {
    dynamic response = await _apiService.getApi(AppUrl.employeeById(id));

    if (response != null && response is Map<String, dynamic>) {
      return EmployeeModel.fromJson(response);
    } else {
      return null;
    }
  }


  Future<List<EmployeeModel>> getEmployeeAvailable(String work_shift_id, String date) async {
    dynamic response = await _apiService.getApi(AppUrl.employeeAvailable(work_shift_id, date));
    if (response != null && response is List) {
      List<EmployeeModel> employeeList = List<EmployeeModel>.from(
        response.map((employee) => EmployeeModel.fromJson(employee)).toList(),
      );
      return employeeList;
    }
    else {
      return [];
    }
  }

}