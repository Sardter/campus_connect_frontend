import 'dart:async';

import 'package:campus_connect_frontend/messaging/messaging.dart';
import 'package:campus_connect_frontend/users/users.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';

class RoomWidget extends StatefulWidget {
  const RoomWidget({super.key, required this.room});
  final User room;

  @override
  State<RoomWidget> createState() => _RoomWidgetState();
}

class _RoomWidgetState extends State<RoomWidget> {
  final _messageService = MessageServiceFactory.SERVICE;

  List<MessageModel> _unread = [];
  String? _lastMessage;

  Timer? _timer;

  Future<void> _getUnreadMessages() async {
    _unread = await _messageService.getList(queryParameters: MessageQueryParameters(
      read: false,
      room: widget.room
    )) ?? [];


    _unread = _unread.where((element) => element.author == widget.room).toList();

    if (_unread.isNotEmpty) _lastMessage = _unread.first.content;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((a) {
      _getUnreadMessages();
    });
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _getUnreadMessages();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await launchPage(
            context,
            ChatPage(
              room: widget.room,
            ));
      },
      child: Container(
        color: Colors.transparent,
        margin: EdgeInsets.symmetric(
            horizontal: getResponsiveMarginWidth(context), vertical: 5),
        padding: const EdgeInsets.all(5),
        child: Stack(
          children: [
            if (_unread.isNotEmpty)
              Badge(label: Text(_unread.length.toString())),
            Row(
              children: [
                SocialUtilImageProvider(
                    image: widget.room.profilePhoto, defaultImage: null),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.room.email,
                        style: const TextStyle(
                          fontSize: 20,
                        )),
                    const SizedBox(height: 5),
                    Text(_lastMessage ?? "No unread messages yet",
                        style:
                            const TextStyle(color: ThemeService.secondaryText))
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
