import 'package:get/get.dart';
import 'package:manage_app/models/exit_model.dart';

import '../../repository/exit_repository.dart';
import '../../routes/route_name.dart';
import '../../utils/utils.dart';

class ExitViewModel extends GetxController{
  final _api = ExitRepository();

  var exitRequest = <ExitModel>[].obs;
  RxBool loadData = false.obs;
  String textStatus = "Chưa duyệt";
  RxBool status = false.obs;


  String? date;
  String? workShiftId;
  String? employeeId;
  int? id;


  Future<void> getExitRequets() async {
    try {
      loadData.value = false;
      List<ExitModel> exitModel = await _api.getExitRequets();
      exitRequest.assignAll(exitModel);
      loadData.value = true;
    } catch (error) {
      print(error.toString());
      Utils.snackBar("Lỗi", error.toString());
    }
  }

  void exitDetail(ExitModel? exit){
    date = exit!.workSchedule!.date;
    id = exit.id;
    Get.toNamed(RouteName.exitApprovalDetail, arguments: exit);
  }

  void approvalExit() {
    Map<String, dynamic> data;
    if (status.value == true) {
        data = {
          'id': id,
          'status': 'approved',
        };
    } else {
      data = {
        'id': id,
        'status': 'rejected',
      };
    }

    _api.approvalExit(data).then((value) {
      getExitRequets();
      Utils.snackBar("Duyệt ra ngoài", "Đã duyệt ra ngoài thành công!");
    }).onError((error, stackTrace) {
      Utils.snackBar("Lỗi", error.toString());
    });
  }



}