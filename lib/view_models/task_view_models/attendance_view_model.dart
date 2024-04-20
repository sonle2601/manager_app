import 'package:get/get.dart';
import 'package:manage_app/models/attendance_model.dart';
import 'package:manage_app/repository/attendance_repository.dart';

import '../../routes/route_name.dart';
import '../../utils/utils.dart';

class AttendanceViewModel extends GetxController{
  final _api = AttendanceRepository();
  String? employeeId;


  var atendances = <AttendanceModel>[].obs;
  var atendancesRequest = <AttendanceModel>[].obs;

  RxBool status = false.obs;
  RxBool loadData = false.obs;
  int? id;



  Future<void> getAttendance() async {
    try {
      loadData.value = false;
      List<AttendanceModel> atendanceModel = await _api.getAttendance(employeeId!);
      atendances.assignAll(atendanceModel);
      loadData.value = true;
    } catch (error) {
      print(error.toString());
      Utils.snackBar("Lỗi", error.toString());
    }
  }

  Future<void> getAttendanceRequets() async {
    try {
      loadData.value = false;
      List<AttendanceModel> atendanceModel = await _api.getAttendanceApproval();
      atendancesRequest.assignAll(atendanceModel);
      loadData.value = true;
    } catch (error) {
      print(error.toString());
      Utils.snackBar("Lỗi", error.toString());
    }
  }

  void attendanceDetail(AttendanceModel? attendanceModel){
    id = attendanceModel!.id;
    Get.toNamed(RouteName.attendanceApprovalDetail, arguments: attendanceModel);
  }

  void attendanceApproval() {
    Map<String, dynamic> data;
    if (status.value == true) {
      data = {
        'status': 'approved',
        'id': id,
      };
    } else {
      data = {
        'id': id,
        'status': 'refuse',
      };
    }

    _api.attendanceApproval(data).then((value) {
      Utils.snackBar("Chấm công", "Đã duyệt chấm công bổ sung thành công!");
      Get.toNamed(RouteName.approvalScreen);
    }).onError((error, stackTrace) {
      Utils.snackBar("Lỗi", error.toString());
    });
  }

}