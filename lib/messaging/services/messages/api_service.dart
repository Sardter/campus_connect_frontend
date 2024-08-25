import 'dart:async';

import 'package:campus_connect_frontend/auth/services/auth.dart';
import 'package:campus_connect_frontend/config/URL_Manager.dart';
import 'package:campus_connect_frontend/messaging/messaging.dart';
import 'package:campus_connect_frontend/users/users.dart';
import 'package:campus_connect_frontend/utilities/services/hide_and_reportable_api_model_service.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MessageAPIService extends HideAndReportableAPIModelService<MessageModel>
    implements MessageService {
  WebSocketChannel? channel;

  @override
  Future<void> createNotificationFromData(MessageModel data) {
    return MessageTestService().createNotificationFromData(data);
  }

  @override
  Stream<String>? get chatStream => protectedChatStream;

  @override
  final unreadCount = ValueNotifier<int>(0);

  @override
  ValueNotifier<int> get getUnreadCount => unreadCount;

  @override
  Future<void> onNewNotification(User currentUser) async {
    var unread = await getList(
            queryParameters: const MessageQueryParameters(read: false, received: true)) ??
        [];
    unread = unread.where((e) => e.author != currentUser).toList();
    
    print(unread.toString());

    unreadCount.value = unread.length;

    for (var element in unread) {
      createNotificationFromData(element);
    }
  }

  @override
  void startStream() async {
    print("aaaaaaaaaaaaaaaaaaaaaaa yeteerrrrrrr");

    final user = await ServiceFactory.userService.getProfile();

    if (user == null) return;

    if (timer != null) return;
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      onNewNotification(user);
    });

    final url =
        "$webSocketUrl/${(await APIAuthServiceFactory.SERVICE.credentials)!.accessToken}";

    print("web socket url:  $url");

    channel = WebSocketChannel.connect(Uri.parse(url));
    protectedChatStream = channel?.stream.asBroadcastStream().cast<String>();
  }

  @override
  void endStream() {
    timer?.cancel();
    timer = null;
    protectedChatStream = null;
  }

  Future<int?> _readUnreadMessages({required User room}) async {
    return await api.actionAndGetResponseItems(
        action: APIAction.post,
        url: "${url}read",
        authService: authService,
        body: {'other': room.id});
  }

  @override
  Future<bool?> readUnreadMessages({required User room}) async {
    return await _readUnreadMessages(room: room) != null;
  }

  @override
  APIService get api => APIServiceFactory.SERVICE;

  @override
  AuthService get authService => APIAuthServiceFactory.SERVICE;

  @override
  ModelFactory<MessageModel> get modelFactory => MessageModelFactory();

  @override
  String get modelType => "message";

  @override
  String get url => URLManager.messages;

  String get webSocketUrl => URLManager.messagesWebSocket;

  @override
  Stream<String>? protectedChatStream;

  @override
  Timer? timer;
}
