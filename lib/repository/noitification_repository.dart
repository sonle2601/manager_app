import 'package:manage_app/models/notification_model.dart';

import '../data/network/network_api_services.dart';
import '../utils/app_url.dart';

class NotificationRepository{
  final _apiService = NetworkApiServices();

  Future<List<NotificationModel>> getNotification() async {

    dynamic response = await _apiService.getApi(AppUrl.notification);

    if (response != null && response is List) {
      List<NotificationModel> notificationModel = List<NotificationModel>.from(
        response.map((notification) => NotificationModel.fromJson(notification)).toList(),
      );
      return notificationModel;
    }
    else {
      return [];
    }
  }
}