import 'package:manage_app/models/late_early_model.dart';

import '../data/network/network_api_services.dart';
import '../utils/app_url.dart';

class LateEarlyRepository {
  final _apiService = NetworkApiServices();

  Future<List<LateEarlyModel>> getLateEarlyRequets() async {

    dynamic response = await _apiService.getApi(AppUrl.lateEarlyRequets);

    if (response != null && response is List) {
      List<LateEarlyModel> leaveModel = List<LateEarlyModel>.from(
        response.map((leave) => LateEarlyModel.fromJson(leave)).toList(),
      );
      return leaveModel;
    }
    else {
      return [];
    }
  }

  Future<dynamic> lateEarlyApproval(var data){
    dynamic response = _apiService.putApi(data, AppUrl.lateEarlyRequets);
    return response;
  }
}