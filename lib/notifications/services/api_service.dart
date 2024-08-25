import 'dart:async';

import 'package:campus_connect_frontend/auth/services/auth.dart';
import 'package:campus_connect_frontend/config/URL_Manager.dart';
import 'package:campus_connect_frontend/notifications/notifications.dart';
import 'package:campus_connect_frontend/utilities/services/hide_and_reportable_api_model_service.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';

class NotificationAPIService
    extends HideAndReportableAPIModelService<NotificationModel>
    implements NotificationService {
  Timer? _timer;

  Future<dynamic> _resetUnread() async {
    return await api.actionAndGetResponseItems(
        url: url,
        authService: authService,
        action: APIAction.post);
  }

  @override
  APIService get api => APIServiceFactory.SERVICE;

  @override
  AuthService get authService => APIAuthServiceFactory.SERVICE;

  @override
  ModelFactory<NotificationModel> get modelFactory => NotificationFactory();

  @override
  String get modelType => "notification";

  @override
  String get url => URLManager.notifications;

  @override
  Future<int?> resetUnread() async {
    (await _resetUnread());
    return 0;
  }

  @override
  final unreadCount = ValueNotifier<int>(0);

  @override
  ValueNotifier<int> get getUnreadCount => unreadCount;

  @override
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

  @override
  Future<void> createNotificationFromData(NotificationModel data) {
    return NotificationTestService().createNotificationFromData(data);
  }

  @override
  void startStream() {
    if (_timer != null) return;
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      onNewNotification();
    });
  }

  @override
  void endStream() {
    _timer?.cancel();
    _timer = null;
  }
}
