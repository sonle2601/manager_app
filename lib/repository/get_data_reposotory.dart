
import 'package:get/get.dart';
import 'package:manage_app/data/network/network_api_services.dart';
import 'package:manage_app/models/parts_model.dart';

import '../utils/app_url.dart';

class GetDataRepository{
  final _apiService = NetworkApiServices();

  Future<List<PartsModel>> getParts() async {
    dynamic response = await _apiService.getApi(AppUrl.part);

    if (response != null && response is List) {
      List<PartsModel> partsList = List<PartsModel>.from(
        response.map((part) => PartsModel.fromJson(part)).toList(),
      );
      return partsList;
    }
    else {
      return [];
    }
  }


}