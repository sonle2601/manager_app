import 'package:manage_app/data/network/network_api_services.dart';
import 'package:manage_app/models/work_shift_model.dart';

import '../utils/app_url.dart';

class WorkShiftRepository {
  final _apiService = NetworkApiServices();


  Future<List<WorkShiftModel>> getWorkShift() async {
    dynamic response = await _apiService.getApi(AppUrl.workShift);

    if (response != null && response is List) {
      List<WorkShiftModel> workShiftList = List<WorkShiftModel>.from(
        response.map((part) => WorkShiftModel.fromJson(part)).toList(),
      );
      return workShiftList;
    }
    else {
      return [];
    }
  }

  Future<dynamic> addWorkShift(var data){
    dynamic response = _apiService.postApi(data, AppUrl.workShift);
    return response;
  }

  Future<dynamic> updateWorkShift(var data){
    dynamic response = _apiService.putApi(data, AppUrl.workShift);
    return response;
  }

}