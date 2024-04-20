class TimeClockDeviceModel {
  int? id;
  String? deviceName;
  String? macAddress;

  TimeClockDeviceModel({
    this.id,
    this.deviceName,
    this.macAddress,
  });

  TimeClockDeviceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ;
    deviceName = json['device_name'];
    macAddress = json['mac_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['device_name'] = this.deviceName;
    data['mac_address'] = this.macAddress;
    if(id != null){
      data['id'] = this.id;
    }
    return data;
  }
}