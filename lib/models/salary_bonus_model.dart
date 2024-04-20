import 'employee_model.dart';

class SalaryBonusModel {
  int? id;
  int? employeeId;
  String? reason;
  String? amount;
  String? createdAt;
  EmployeeModel? employee;


  SalaryBonusModel({
    this.id,
    this.employeeId,
    this.reason,
    this.amount,
    this.createdAt,
    this.employee
  });

  SalaryBonusModel.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    reason = json['reason'];
    amount = json['amount'];
    createdAt = json['created_at'];
    employee = json['employee'] != null
        ? new EmployeeModel.fromJson(json['employee'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_id'] = this.employeeId;
    data['reason'] = this.reason;
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    return data;
  }
}