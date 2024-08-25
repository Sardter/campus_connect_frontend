import 'dart:async';
import 'dart:convert';

import 'package:campus_connect_frontend/messaging/messaging.dart';
import 'package:campus_connect_frontend/users/models/user.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class MessageService extends ModelService<MessageModel> {
  final _notifications = FlutterLocalNotificationsPlugin();

  int _id = 0;

  @protected
  Stream<String>? protectedChatStream;

  @protected
  Timer? timer;

  Stream<String>? get chatStream => protectedChatStream;

  @protected
  final unreadCount = ValueNotifier<int>(0);

  ValueNotifier<int> get getUnreadCount => unreadCount;

  @mustCallSuper
  Future<void> onNewNotification(User currentUser) async {

    final unread = await getList(
            queryParameters: const MessageQueryParameters(read: false)) ??
        [];

    unreadCount.value = unread.length;

    for (var element in unread) {
      createNotificationFromData(element);
    }
  }

  Future<void> createNotificationFromData(MessageModel data) async {
    return await _notifications.show(
        ++_id,
        data.author.displayName,
        data.content,
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

  void startStream() async {
    final user = await ServiceFactory.userService.getProfile();

    if (user == null) return;
    if (timer != null) return;
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      onNewNotification(user);
    });
  }

  void endStream() {
    timer?.cancel();
    timer = null;
    protectedChatStream = null;
  }

  Future<bool?> readUnreadMessages({required User room});
}
