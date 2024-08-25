import 'dart:async';
import 'dart:convert';

import 'package:campus_connect_frontend/notifications/notifications.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class NotificationService extends ModelService<NotificationModel> {
  final _notifications = FlutterLocalNotificationsPlugin();
  Timer? _timer;
  int _id = 0;

  @protected
  final unreadCount = ValueNotifier<int>(0);

  @mustCallSuper
  Future<int?> resetUnread() async {
    unreadCount.value = 0;
    return 0;
  }

  ValueNotifier<int> get getUnreadCount => unreadCount;

  @mustCallSuper
  Future<void> onNewNotification() async {
    final user = await ServiceFactory.userService.getProfile();
    if (user == null) return;
    final unread = await getList(
            queryParameters: const NotificationQueryParameters(seen: false)) ??
        [];

    unreadCount.value = unread.length;

    for (var element in unread) {
      createNotificationFromData(element);
    }
  }

  Future<void> createNotificationFromData(NotificationModel data) async {
    return await _notifications.show(
        ++_id,
        data.title,
        data.description,
        const NotificationDetails(
            android: AndroidNotificationDetails(
              "social",
              "social",
              ledOffMs: 500,
              ledOnMs: 500,
              ledColor: ThemeService.eventColor,
              priority: Priority.max,
              groupAlertBehavior: GroupAlertBehavior.all,
            ),
            iOS: DarwinNotificationDetails(attachments: [])),
        payload: jsonEncode({'time': data.id.toString(), 'item_id': data.id}));
  }

  void startStream() {
    if (_timer != null) return;
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      onNewNotification();
    });
  }

  void endStream() {
    _timer?.cancel();
    _timer = null;
  }
}
