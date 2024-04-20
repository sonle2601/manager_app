import 'package:manage_app/models/work_schedule_model.dart';

class AttendanceModel {
  int? id;
  String? checkIn;
  String? checkOut;
  int? minutesOut;
  String? status;
  String? date;
  int? totalMinutes;
  String? createdAt;
  WorkScheduleModel? workSchedule;



  AttendanceModel(
      {this.id,
        this.checkIn,
        this.checkOut,
        this.minutesOut,
        this.status,
        this.workSchedule,
        this.totalMinutes,
        this.createdAt,
        this.date});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    checkIn = json['check_in'];
    checkOut = json['check_out'];
    minutesOut = json['minutes_out'];
    status = json['status'];
    date = json['date'];
    totalMinutes = json['total_minutes'];
    createdAt = json['created_at'];
    workSchedule = json['work_schedule'] != null
        ? new WorkScheduleModel.fromJson(json['work_schedule'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['check_in'] = this.checkIn;
    data['check_out'] = this.checkOut;
    data['minutes_out'] = this.minutesOut;
    data['status'] = this.status;
    data['date'] = this.date;
    data['total_minutes'] = this.totalMinutes;
    data['created_at'] = this.createdAt;
    if (this.workSchedule != null) {
      data['work_schedule'] = this.workSchedule!.toJson();
    }

    return data;
  }
}