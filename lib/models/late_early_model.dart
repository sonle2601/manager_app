import 'package:manage_app/models/work_schedule_model.dart';

class LateEarlyModel {
  int? id;
  int? workScheduleId;
  String? type;
  String? status;
  String? reason;
  String? time;
  int? storeId;
  String? createdAt;
  WorkScheduleModel? workSchedule;


  LateEarlyModel(
      {this.id,
        this.workScheduleId,
        this.type,
        this.status,
        this.reason,
        this.time,
        this.storeId,
        this.workSchedule,
        this.createdAt});

  LateEarlyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workScheduleId = json['work_schedule_id'];
    type = json['type'];
    status = json['status'];
    reason = json['reason'];
    time = json['time'];
    storeId = json['store_id'];
    createdAt = json['created_at'];
    workSchedule = json['work_schedule'] != null
        ? new WorkScheduleModel.fromJson(json['work_schedule'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['work_schedule_id'] = this.workScheduleId;
    data['type'] = this.type;
    data['status'] = this.status;
    data['reason'] = this.reason;
    data['time'] = this.time;
    data['store_id'] = this.storeId;
    data['created_at'] = this.createdAt;
    if (this.workSchedule != null) {
      data['work_schedule'] = this.workSchedule!.toJson();
    }
    return data;
  }
}