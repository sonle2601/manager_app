import 'employee_model.dart';

class SalaryModel {
  int? id;
  int? totalSalary;
  String? salaryHour;
  int? totalMinutes;
  int? totalSalaryBonus;
  int? totalSalaryPenalty;
  EmployeeModel? employee;

  SalaryModel(
      {
        this.id,
        this.totalSalary,
        this.salaryHour,
        this.totalMinutes,
        this.totalSalaryBonus,
        this.totalSalaryPenalty,
        this.employee
      });

  SalaryModel.fromJson(Map<String, dynamic> json) {
    totalSalary = json['total_salary'];
    salaryHour = json['salary_hour'];
    totalMinutes = json['total_minutes'];
    totalSalaryBonus = json['totalSalary_bonus'];
    totalSalaryPenalty = json['totalSalary_penalty'];
    employee = json['employee'] != null
        ? new EmployeeModel.fromJson(json['employee'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_salary'] = this.totalSalary;
    data['salary_hour'] = this.salaryHour;
    data['total_minutes'] = this.totalMinutes;
    data['totalSalary_bonus'] = this.totalSalaryBonus;
    data['totalSalary_penalty'] = this.totalSalaryPenalty;
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    return data;
  }
}