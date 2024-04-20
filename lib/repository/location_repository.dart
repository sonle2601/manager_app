

import '../data/network/network_api_services.dart';
import '../utils/app_url.dart';

class LocationRepository{
  final _apiService = NetworkApiServices();

   Future<List<dynamic>> getProvinces() async{
      dynamic response = await _apiService.getApi(AppUrl.getProvinces);
    return response['results'];
  }

  Future<List<dynamic>> getDistricts(String provinceId)async{
    dynamic response =await _apiService.getApi(AppUrl.getDistricts(provinceId));
    return response['results'];
  }

  Future<List<dynamic>> getWards(String districtId) async{
    dynamic response = await _apiService.getApi(AppUrl.getWards(districtId));
    return response['results'];
  }
}