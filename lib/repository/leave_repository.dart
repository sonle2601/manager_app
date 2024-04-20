import 'dart:developer';

import 'package:manage_app/models/leave_model.dart';

import '../data/network/network_api_services.dart';
import '../utils/app_url.dart';

class LeaveRepository{
  final _apiService = NetworkApiServices();

  Future<List<LeaveModel>> getLeaveRequets() async {

    dynamic response = await _apiService.getApi(AppUrl.leaveRequets);

    if (response != null && response is List) {
      List<LeaveModel> leaveModel = List<LeaveModel>.from(
        response.map((leave) => LeaveModel.fromJson(leave)).toList(),
      );
      return leaveModel;
    }
    else {
      return [];
    }
  }

  Future<dynamic> approvalLeave(var data){
    dynamic response = _apiService.putApi(data, AppUrl.leaveRequets);
    return response;
  }

}