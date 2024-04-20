class WorkShiftModel {
  int? id;
  String? name;
  String? startTime;
  String? endTime;
  int? status;
  int? storeId;

  WorkShiftModel(
      {this.id,
        this.name,
        this.startTime,
        this.endTime,
        this.status,
        this.storeId});

  WorkShiftModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
    storeId = json['store_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(id != null){
      data['id'] = this.id;
    }
    data['name'] = this.name;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    if(status != null){
      data['status'] = this.status;
    }
    data['store_id'] = this.storeId;
    return data;
  }
}