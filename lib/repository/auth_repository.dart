
import '../data/network/network_api_services.dart';
import '../utils/app_url.dart';

class AuthRepository{
  final _apiService = NetworkApiServices();

  Future<dynamic> register(var data){
    dynamic response = _apiService.postApi(data, AppUrl.register);
    return response;
  }

  Future<dynamic> login(var data){
    dynamic response = _apiService.postApi(data, AppUrl.login);
    return response;
  }

  Future<dynamic> update(var data){
    dynamic response = _apiService.putApi(data, AppUrl.login);
    return response;
  }

  Future<dynamic> checkStore(){
    dynamic response = _apiService.getApi(AppUrl.checkStore);
    return response;
  }

}