import 'package:manage_app/models/attendance_model.dart';

import '../data/network/network_api_services.dart';
import '../utils/app_url.dart';

class AttendanceRepository {
  final _apiService = NetworkApiServices();

  Future<List<AttendanceModel>> getAttendance(String employeeId) async {

    dynamic response = await _apiService.getApi(AppUrl.attendance(employeeId));

    if (response != null && response is List) {
      List<AttendanceModel> attendanceModel = List<AttendanceModel>.from(
        response.map((attendance) => AttendanceModel.fromJson(attendance)).toList(),
      );
      return attendanceModel;
    }
    else {
      return [];
    }
  }

  Future<List<AttendanceModel>> getAttendanceApproval() async {

    dynamic response = await _apiService.getApi(AppUrl.attendanceRequest);

    if (response != null && response is List) {
      List<AttendanceModel> attendanceModel = List<AttendanceModel>.from(
        response.map((attendance) => AttendanceModel.fromJson(attendance)).toList(),
      );
      return attendanceModel;
    }
    else {
      return [];
    }
  }
  Future<dynamic> attendanceApproval(var data){
    dynamic response = _apiService.putApi(data, AppUrl.attendanceRequest);
    return response;
  }


}