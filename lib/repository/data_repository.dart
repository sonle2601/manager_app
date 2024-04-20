
import '../data/network/network_api_services.dart';
import '../utils/app_url.dart';

class PostDataRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> postInformation(var data){
    dynamic response = _apiService.postApi(data, AppUrl.infomation);
    return response;
  }

  Future<dynamic> addParts(var data){
    dynamic response = _apiService.postApi(data, AppUrl.part);
    return response;
  }

  Future<dynamic> updateParts(var data) async{
    dynamic response = await _apiService.postApi(data, AppUrl.updatePart);
    return response;
  }


}