import '../data/network/network_api_services.dart';
import '../models/store_model.dart';
import '../utils/app_url.dart';

class ManagerRepository{
  final _apiService = NetworkApiServices();

  Future<dynamic> postStore(var data){
    dynamic response = _apiService.postApi(data, AppUrl.store);
    return response;
  }

  Future<StoreModel> getStore() async {
    dynamic response = await _apiService.getApi(AppUrl.store);
    StoreModel store = StoreModel.fromJson(response);
    return store;
  }



}