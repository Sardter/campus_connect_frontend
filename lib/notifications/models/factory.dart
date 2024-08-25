import 'package:campus_connect_frontend/notifications/models/notification.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class NotificationFactory extends ModelFactory<NotificationModel> {
  @override
  NotificationModel fromJson(Map<String, dynamic> json) {
    return NotificationModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        image: json['image'] == null
            ? null
            : NetworkImageData(url: json['image']));
  }
}
