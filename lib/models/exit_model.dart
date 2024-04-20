import 'package:manage_app/models/work_schedule_model.dart';

class ExitModel {
  int? id;
  int? workScheduleId;
  String? reason;
  int? minutesOut;
  String? status;
  int? storeId;
  String? createdAt;
  WorkScheduleModel? workSchedule;



  ExitModel(
      {this.id,
        this.workScheduleId,
        this.reason,
        this.minutesOut,
        this.status,
        this.storeId,
        this.workSchedule,
        this.createdAt});

  ExitModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workScheduleId = json['work_schedule_id'];
    reason = json['reason'];
    minutesOut = json['minutes_out'];
    status = json['status'];
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
    data['reason'] = this.reason;
    data['minutes_out'] = this.minutesOut;
    data['status'] = this.status;
    data['store_id'] = this.storeId;
    data['created_at'] = this.createdAt;
    if (this.workSchedule != null) {
      data['work_schedule'] = this.workSchedule!.toJson();
    }
    return data;
  }
}