import 'dart:async';
import 'dart:convert';

import 'package:campus_connect_frontend/messaging/messaging.dart';
import 'package:campus_connect_frontend/users/models/user.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.room});
  final User room;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messageService = MessageServiceFactory.SERVICE;

  List<types.Message> _messages = [];
  User? _user;
  StreamSubscription<String>? _streamSubscription;

  Future<void> init() async {
    _user = await ServiceFactory.userService.getProfile();

    if (_user == null) {
      // ignore: use_build_context_synchronously
      closePage(context);
      return;
    }

    setState(() {});

    _messageService.startStream();

    await _messageService.readUnreadMessages(room: widget.room);
    await _loadMessages();
    listenToStream();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  void _addMessage(types.Message message) {
    _messages.insert(0, message);
  }

  void _handleSendPressed(types.PartialText message) async {
    /* final response = await _messageService.postItem(
        item: MessageModel.fromPartialText(message, widget.room.id, _user!));

    if (response != null) _addMessage(response.uiComponent);
    setState(() {}); */

    if (ServiceFactory.mode == ServiceFactoryMode.api) {
      final data = MessageModel.fromPartialText(message, widget.room.id, _user!)
          .toJson();
      print(data.toString());
      (_messageService as MessageAPIService)
          .channel
          ?.sink
          .add(jsonEncode(data));
    }
  }

  Future<void> _loadMessages() async {
    final messages = await _messageService.getList(
            queryParameters: MessageQueryParameters(room: widget.room)) ??
        [];

    setState(() {
      _messages = messages.map((e) => e.uiComponent).toList();
    });

    _messageService.readUnreadMessages(room: widget.room);
  }

  void listenToStream() {
    _streamSubscription = _messageService.chatStream?.listen((event) {
      //print("chat event: $event");
      try {
        final data = jsonDecode(event);

        //print("chat data: $data");

        final message = MessageModelFactory().fromJson(data);

        _addMessage(message.uiComponent);
        if (message.author != _user) {
          _messageService.readUnreadMessages(room: widget.room);
          for (var i = 0; i < _messages.length; i++) {
            _messages[i] = _messages[i].copyWith(status: types.Status.seen);
          }
        }
        setState(() {});
      } catch (e) {
        print(e);
        print("chat error:  ${e.toString()}");
      }
    });
  }

  @override
  void dispose() {
    _messageService.endStream();
    _streamSubscription?.cancel();
    _streamSubscription = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
          body: AppPage(
        title: widget.room.email,
        body: _user == null
            ? const LoadingIndicator()
            : Chat(
                messages: _messages,
                onSendPressed: _handleSendPressed,
                showUserAvatars: true,
                theme: const DefaultChatTheme(),
                showUserNames: true,
                user: _user!.chatUIUser,
              ),
      ));
}
