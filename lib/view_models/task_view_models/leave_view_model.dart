import 'dart:developer';

import 'package:get/get.dart';
import 'package:manage_app/models/leave_model.dart';
import 'package:manage_app/repository/leave_repository.dart';

import '../../routes/route_name.dart';
import '../../utils/utils.dart';

class LeaveViewModel extends GetxController{
  final _api = LeaveRepository();

  var leaveRequest = <LeaveModel>[].obs;
  RxBool loadData = false.obs;
  String textStatus = "Chưa duyệt";
  RxBool status = false.obs;


  String? date;
  String? workShiftId;
  String? employeeId;
  int? id;


  Future<void> getLeaveRequets() async {
    try {
      loadData.value = false;
      List<LeaveModel> leaveModel = await _api.getLeaveRequets();
      leaveRequest.assignAll(leaveModel);
      loadData.value = true;
    } catch (error) {
      print(error.toString());
      Utils.snackBar("Lỗi", error.toString());
    }
  }

  void leaveDetail(LeaveModel? leave){
    date = leave!.workSchedule!.date;
    workShiftId = leave!.workSchedule!.workShiftId.toString();
    id = leave.id;
    Get.toNamed(RouteName.leaveApprovalDetail, arguments: leave);
  }

  void approvalLeave() {
    Map<String, dynamic> data;
    if (status.value == true) {
      if (employeeId != null) {
        data = {
          'status': 'accept',
          'date': date,
          'work_shift_id': workShiftId,
          'employee_id': employeeId,
          'id': id,
        };
      } else {
        data = {
          'id': id,
          'status': 'accept',
        };
      }
    } else {
      data = {
        'id': id,
        'status': 'refuse',
      };
    }

    _api.approvalLeave(data).then((value) {
      Utils.snackBar("Duyệt nghỉ ca", "Đã duyệt lịch nghỉ!");
      Get.toNamed(RouteName.approvalScreen);
    }).onError((error, stackTrace) {
      Utils.snackBar("Lỗi", error.toString());
    });
  }



}