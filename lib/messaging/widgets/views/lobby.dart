import 'dart:async';

import 'package:campus_connect_frontend/messaging/widgets/components/room.dart';
import 'package:campus_connect_frontend/users/users.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';

import '../../../home/widgets/components/appbar.dart';

class ChatsLobby extends StatefulWidget {
  const ChatsLobby({super.key});

  @override
  State<ChatsLobby> createState() => _ChatsLobbyState();
}

class _ChatsLobbyState extends State<ChatsLobby> {
  List<User> _rooms = [];
  Timer? _timer;
  User? _user;

  @override
  void initState() {
    super.initState();
    _onRefresh();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _onRefresh();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  Future<void> _onRefresh() async {
    _user = await ServiceFactory.userService.getProfile();

    if (_user == null) {
      // ignore: use_build_context_synchronously
      _timer?.cancel();
      _timer = null;
      return;
    }

    _rooms = await ServiceFactory.userService
            .getList(queryParameters: const UserQueryParameters(chat: true)) ??
        [];

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final rooms = _rooms.toList();
    return Scaffold(
      appBar: ConnectAppBar(context: context, selectedIndex: 1),
      body: _user == null
          ? const Center(
              child: Text("You need to login first"),
            )
          : ListView.builder(
              itemCount: rooms.length,
              itemBuilder: (context, index) => RoomWidget(room: rooms[index])),
    );
  }
}
