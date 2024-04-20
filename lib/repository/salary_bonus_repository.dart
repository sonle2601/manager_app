import 'package:manage_app/models/salary_bonus_model.dart';

import '../data/network/network_api_services.dart';
import '../utils/app_url.dart';

class SaralyBonusRepository{
  final _apiService = NetworkApiServices();

  Future<List<SalaryBonusModel>> getSaralyBonus() async {

    dynamic response = await _apiService.getApi(AppUrl.salaryBonus);

    if (response != null && response is List) {
      List<SalaryBonusModel> salaryBonusModel = List<SalaryBonusModel>.from(
        response.map((salaryBonus) => SalaryBonusModel.fromJson(salaryBonus)).toList(),
      );
      return salaryBonusModel;
    }
    else {
      return [];
    }
  }

  Future<dynamic> addSalaryBonus(var data){
    dynamic response = _apiService.postApi(data, AppUrl.salaryBonus);
    return response;
  }

}