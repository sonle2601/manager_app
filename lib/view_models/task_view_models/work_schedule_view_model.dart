import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:manage_app/models/work_schedule_model.dart';
import 'package:manage_app/repository/work_schedule_repository.dart';

import '../../utils/utils.dart';

class WorkScheduleViewModel extends GetxController{
   String? date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final _api = WorkScheduleRepository();
  var workSchedule = <WorkScheduleModel>[].obs;

  String? dateAdd;
  int? idWorkShifts;
  List<int>? idEmployee;

  @override
  void onInit() {
    super.onInit();
  }

  RxBool loadData = false.obs;

  Future<void> getworkSchedule() async {
    try {
      loadData.value = false;
      List<WorkScheduleModel> workScheduleModel = await _api.getWorkSchedule(date.toString());
      workSchedule.assignAll(workScheduleModel);
      loadData.value = true;
    } catch (error) {
      print(error.toString());
      Utils.snackBar("Lỗi", error.toString());
    }
  }



   void addWorkSchedule() {
     List<WorkScheduleModel> workSchedules = [];

     print(dateAdd.toString());
     for (int id in idEmployee!) {
       WorkScheduleModel workSchedule = WorkScheduleModel(
         date: dateAdd,
         workShiftId: idWorkShifts,
         employeeId: id,
       );
       workSchedules.add(workSchedule);
     }

     List<Map<String, dynamic>> dataList = workSchedules.map((workSchedule) => workSchedule.toJson()).toList();

     // Gọi API để thêm mới các lịch làm việc
     _api.addEmployee(dataList).then((value) {
       Utils.snackBar("Ca làm việc", "Thêm mới ca làm việc thành công!");
       getworkSchedule();
     }).onError((error, stackTrace) {
       print(error.toString());
       Utils.snackBar("Loi", error.toString());
     });
   }



}