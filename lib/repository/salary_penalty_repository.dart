import 'package:manage_app/models/salary_penalty_model.dart';

import '../data/network/network_api_services.dart';
import '../utils/app_url.dart';

class SaralyPenaltyRepository{
  final _apiService = NetworkApiServices();

  Future<List<SalaryPenaltyModel>> getSaralyPenalty() async {

    dynamic response = await _apiService.getApi(AppUrl.salaryPenalty);

    if (response != null && response is List) {
      List<SalaryPenaltyModel> salaryPenaltyModel = List<SalaryPenaltyModel>.from(
        response.map((salaryPenalty) => SalaryPenaltyModel.fromJson(salaryPenalty)).toList(),
      );
      return salaryPenaltyModel;
    }
    else {
      return [];
    }
  }

  Future<dynamic> addSalaryPenalty(var data){
    dynamic response = _apiService.postApi(data, AppUrl.salaryPenalty);
    return response;
  }

}