import 'attendance_model.dart';
import 'exit_model.dart';
import 'late_early_model.dart';
import 'leave_model.dart';

class NotificationModel {
  int? id;
  String? title;
  String? content;
  String? type;
  int? userId;
  String? createdAt;
  LeaveModel? leave;
  LateEarlyModel? lateEarly;
  AttendanceModel? attendance;
  ExitModel? exit;

  NotificationModel(
      {this.id,
        this.title,
        this.content,
        this.type,
        this.userId,
        this.createdAt,
        this.leave,
        this.exit,
        this.attendance,
        this.lateEarly
        });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    type = json['type'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    leave = json['leave_request'] != null ? new LeaveModel.fromJson(json['leave_request']) : null;
    exit = json['exit_request'] != null ? new ExitModel.fromJson(json['exit_request']) : null;
    lateEarly = json['late_early_requests'] != null ? new LateEarlyModel.fromJson(json['late_early_requests']) : null;
    attendance = json['attendance_request'] != null ? new AttendanceModel.fromJson(json['attendance_request']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['type'] = this.type;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    return data;
  }
}