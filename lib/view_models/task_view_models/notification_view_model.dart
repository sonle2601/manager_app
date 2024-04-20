import 'package:get/get.dart';

import '../../models/notification_model.dart';
import '../../repository/noitification_repository.dart';
import '../../repository/salary_penalty_repository.dart';
import '../../utils/utils.dart';

class NotificationViewModel extends GetxController{
  final _api = NotificationRepository();

  var notification = <NotificationModel>[].obs;
  RxBool loadData = false.obs;
  RxBool loading = false.obs;

  Future<void> getNotification() async {
    try {
      loadData.value = false;
      List<NotificationModel> notificationModel = await _api.getNotification();
      notification.assignAll(notificationModel);
      loadData.value = true;
    } catch (error) {
      print(error.toString());
      Utils.snackBar("Lỗi", error.toString());
    }
  }

}