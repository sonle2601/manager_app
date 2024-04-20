import 'package:manage_app/models/user_model.dart';

import '../data/network/network_api_services.dart';
import '../utils/app_url.dart';

class InformationRepository{
  final _apiService = NetworkApiServices();

  Future<dynamic> updateInfoPersonal(var data) async{
    dynamic response = await _apiService.putApi(data, AppUrl.updateInfoUser);
    return response;
  }

  Future<UserModel?> getUserInfo() async {
    dynamic response = await _apiService.getApi(AppUrl.infomationUser);

    if (response != null) {
      if (response is Map<String, dynamic>) {
        return UserModel.fromJson(response);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<dynamic> changePassword(var data) async{
    dynamic response = await _apiService.postApi(data, AppUrl.changePassword);
    return response;
  }

}