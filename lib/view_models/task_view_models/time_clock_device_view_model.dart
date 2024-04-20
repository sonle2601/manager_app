import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';




import '../../models/time_clock_device_model.dart';
import '../../repository/time_clock_device_repository.dart';
import '../../utils/utils.dart';

class TimeClockDeviceViewModel extends GetxController {
  final TimeClockDeviceRepository _api = TimeClockDeviceRepository();

  var timeClockDevice = TimeClockDeviceModel().obs;
  var loadData = false.obs;
  var loadInfoWifi = false.obs;
  final nameController = TextEditingController().obs;
  final macController = TextEditingController().obs;
  RxBool loading = false.obs;
  int? id;


  @override
  void onInit() {
    getTimeClockDevice();
    super.onInit();
  }

  Future<void> getTimeClockDevice() async {
    try {
      loadData.value = false;
      TimeClockDeviceModel? device = await _api.getTimeClockDevice();
      if (device != null) {
        timeClockDevice.value = device;
        id = device.id;
        nameController.update((val) {
          val!.text = device.deviceName.toString(); // Gán giá trị vào nameController
        });
        macController.update((val) {
          val!.text = device.macAddress.toString(); // Gán giá trị vào macController
        });
      }
      loadData.value = true;
    } catch (error) {
      print(error.toString());
      Utils.snackBar("Lỗi", error.toString());
    }
  }


  Future<void> getInfoWifi() async {
    final info = NetworkInfo();
    var locationStatus = await Permission.location.status;
    if (locationStatus.isDenied) {
      await Permission.locationWhenInUse.request();
    }
    if (await Permission.location.isRestricted) {
      openAppSettings();
    }

    if (await Permission.location.isGranted) {
      try {
        var wifiName = await info.getWifiName();
        var wifiBSSID = await info.getWifiBSSID();

        // Loại bỏ dấu nháy kép từ tên Wifi
        wifiName = removeQuotes(wifiName);

        nameController.update((val) {
          val!.text = wifiName ?? ''; // Gán giá trị tên Wifi vào nameController
        });
        macController.update((val) {
          val!.text = wifiBSSID ?? ''; // Gán giá trị địa chỉ MAC vào macController
        });
        Utils.toastMessage("Lấy về thông tin wifi thành công");
      } catch (e) {
        log('Error getting wifi info: $e');
      }
    }
  }

  String? removeQuotes(String? input) {
    if (input == null) return null;
    return input.replaceAll('"', '');
  }


  void updateWorkShiftApi(){
    loading.value = true;

    TimeClockDeviceModel timeClockDeviceModel = TimeClockDeviceModel(
      id:id,
      deviceName: nameController.value.text,
      macAddress: macController.value.text
    );

    Map<String, dynamic> data = timeClockDeviceModel.toJson();

    _api.updateTimeClockDevice(data).then((value) {
      loading.value = false;
      Utils.snackBar("Thiết bị chấm công", "Cập nhật thiết bị chấm công thành công");
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error.toString());
      Utils.snackBar("Loi", error.toString());
    });
  }


}
