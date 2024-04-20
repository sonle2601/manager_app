import 'package:manage_app/models/work_schedule_model.dart';

import '../data/network/network_api_services.dart';
import '../utils/app_url.dart';

class WorkScheduleRepository{
  final _apiService = NetworkApiServices();

  Future<dynamic> addEmployee(var data) async{
    dynamic response = await _apiService.postApi(data, AppUrl.workScheduleAdd);
    return response;
  }

  Future<List<WorkScheduleModel>> getWorkSchedule( String date) async {
    dynamic response = await _apiService.getApi(AppUrl.workSchedule( date));

    if (response != null && response is List) {
      List<WorkScheduleModel> workScheduleList = List<WorkScheduleModel>.from(
        response.map((workSchedule) => WorkScheduleModel.fromJson(workSchedule)).toList(),
      );
      return workScheduleList;
    }
    else {
      return [];
    }
  }
}