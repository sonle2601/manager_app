import 'package:manage_app/models/work_schedule_model.dart';

class LeaveModel {
  int? id;
  int? workScheduleId;
  String? reason;
  String? status;
  String? createdAt;
  WorkScheduleModel? workSchedule;



  LeaveModel(
      {this.workScheduleId,
        this.reason,
        this.status,
        this.id,
        this.workSchedule,
        this.createdAt
      });

  LeaveModel.fromJson(Map<String, dynamic> json) {
    workScheduleId = json['work_schedule_id'];
    reason = json['reason'];
    status = json['status'];
    id = json['id'];
    createdAt = json['created_at'];
    workSchedule = json['work_schedule'] != null
        ? new WorkScheduleModel.fromJson(json['work_schedule'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['work_schedule_id'] = this.workScheduleId;
    data['reason'] = this.reason;
    data['status'] = this.status;
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    if (this.workSchedule != null) {
      data['work_schedule'] = this.workSchedule!.toJson();
    }
    return data;
  }
}