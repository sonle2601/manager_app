import 'package:get/get.dart';
import 'package:manage_app/models/late_early_model.dart';
import 'package:manage_app/repository/late_early_repository.dart';

import '../../routes/route_name.dart';
import '../../utils/utils.dart';

class LateEarlyViewModel extends GetxController{
  final _api = LateEarlyRepository();
  var lateEarlyRequest = <LateEarlyModel>[].obs;
  RxBool loadData = false.obs;
  String textStatus = "Chưa duyệt";
  RxBool status = false.obs;


  String? date;
  String? workShiftId;
  int? id;
  String? time;

  Future<void> getLateEarlyRequets() async {
    try {
      loadData.value = false;
      List<LateEarlyModel> lateEarlyModel = await _api.getLateEarlyRequets();
      lateEarlyRequest.assignAll(lateEarlyModel);
      loadData.value = true;
    } catch (error) {
      print(error.toString());
      Utils.snackBar("Lỗi", error.toString());
    }
  }


  void lateEarlyDetail(LateEarlyModel? lateEarly){
    date = lateEarly!.workSchedule!.date;
    workShiftId = lateEarly!.workSchedule!.workShiftId.toString();
    id = lateEarly.id;
    time = lateEarly.time;
    Get.toNamed(RouteName.lateEarlyApprovalDetail, arguments: lateEarly);
  }

  void lateEarlyapproval() {
    Map<String, dynamic> data;
    if (status.value == true) {
        data = {
          'status': 'approved',
          'time': time,
          'id': id,
        };
    } else {
      data = {
        'id': id,
        'status': 'rejected',
      };
    }

    _api.lateEarlyApproval(data).then((value) {
      Utils.snackBar("Duyệt đi sớm/ về muộn", "Đã duyệt lịch thành công!");
      Get.toNamed(RouteName.approvalScreen);
    }).onError((error, stackTrace) {
      Utils.snackBar("Lỗi", error.toString());
    });
  }
}