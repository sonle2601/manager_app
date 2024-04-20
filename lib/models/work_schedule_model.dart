import 'package:manage_app/models/employee_model.dart';
import 'package:manage_app/models/work_shift_model.dart';

class WorkScheduleModel {
  int? id;
  String? date;
  int? workShiftId;
  int? employeeId;
  int? storeId;
  int? status;
  EmployeeModel? employee;
  WorkShiftModel? workShift;

  WorkScheduleModel(
      {this.id,
        this.date,
        this.workShiftId,
        this.employeeId,
        this.status,
        this.storeId,
        this.employee,
        this.workShift});

  WorkScheduleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    workShiftId = json['work_shift_id'];
    employeeId = json['employee_id'];
    status = json['status'];
    storeId = json['store_id'];
    employee = json['employee'] != null
        ? new EmployeeModel.fromJson(json['employee'])
        : null;
    workShift = json['work_shift'] != null
        ? new WorkShiftModel.fromJson(json['work_shift'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['work_shift_id'] = this.workShiftId;
    data['employee_id'] = this.employeeId;
    data['store_id'] = this.storeId;
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    if (this.workShift != null) {
      data['work_shift'] = this.workShift!.toJson();
    }
    return data;
  }
}
