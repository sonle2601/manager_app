import 'package:manage_app/models/parts_model.dart';
import 'package:manage_app/models/store_model.dart';
import 'package:manage_app/models/user_model.dart';

import 'information_model.dart';

class EmployeeModel {
  int? id;
  int? partId;
  int? storeId;
  int? userId;
  double? salaries;
  String? startTime;
  int? employeeStatus;
  StoreModel? store;
  PartsModel? part;
  UserModel? user;
  InformationModel? information;


  EmployeeModel(
      {this.id,
        this.partId,
        this.storeId,
        this.userId,
        this.salaries,
        this.startTime,
        this.employeeStatus,
        this.store,
        this.part,
        this.user,
        this.information
});

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    partId = json['part_id'];
    storeId = json['store_id'];
    userId = json['user_id'];
    salaries = double.tryParse(json['salaries']) ?? null;
    startTime = json['start_time'];
    employeeStatus = json['employee_status'];
    store = json['store'] != null ? new StoreModel.fromJson(json['store']) : null;
    part = json['part'] != null ? new PartsModel.fromJson(json['part']) : null;
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
    information = json['information'] != null ? new InformationModel.fromJson(json['information']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(id != null){
      data['id'] = this.id;
    }
    data['part_id'] = this.partId;
    if(storeId != null){
      data['store_id'] = this.storeId;
    }
    if(userId != null){
      data['user_id'] = this.userId;
    }
    data['salaries'] = this.salaries;
    data['start_time'] = this.startTime;
    if(employeeStatus != null){
      data['employee_status'] = this.employeeStatus;
    }
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    if (this.part != null) {
      data['part'] = this.part!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.information != null) {
      data['information'] = this.information!.toJson();
    }
    return data;
  }
}