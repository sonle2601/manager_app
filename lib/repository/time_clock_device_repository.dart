import 'dart:developer';

import 'package:manage_app/models/time_clock_device_model.dart';

import '../data/network/network_api_services.dart';
import '../utils/app_url.dart';

class TimeClockDeviceRepository{
  final _apiService = NetworkApiServices();


  Future<TimeClockDeviceModel?> getTimeClockDevice() async {

    dynamic response = await _apiService.getApi(AppUrl.timeClockDevice);

    TimeClockDeviceModel timeClockDevice = TimeClockDeviceModel.fromJson(response);
    return timeClockDevice;
  }


  Future<dynamic> addTimeClockDevice(var data){
    dynamic response = _apiService.postApi(data, AppUrl.timeClockDevice);
    return response;
  }

  Future<dynamic> updateTimeClockDevice(var data){
    dynamic response = _apiService.putApi(data, AppUrl.timeClockDevice);
    return response;
  }
}