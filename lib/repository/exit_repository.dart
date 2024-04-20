import '../data/network/network_api_services.dart';
import '../models/exit_model.dart';
import '../utils/app_url.dart';

class ExitRepository{
  final _apiService = NetworkApiServices();

  Future<List<ExitModel>> getExitRequets() async {

    dynamic response = await _apiService.getApi(AppUrl.exitRequest);

    if (response != null && response is List) {
      List<ExitModel> exitModel = List<ExitModel>.from(
        response.map((exit) => ExitModel.fromJson(exit)).toList(),
      );
      return exitModel;
    }
    else {
      return [];
    }
  }

  Future<dynamic> approvalExit(var data){
    dynamic response = _apiService.putApi(data, AppUrl.exitRequest);
    return response;
  }

}