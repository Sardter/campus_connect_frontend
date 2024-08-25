import 'dart:async';

import 'package:campus_connect_frontend/notifications/notifications.dart';
import 'package:campus_connect_frontend/users/users.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';

import '../../../home/widgets/components/appbar.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final _refreshKey = GlobalKey<RefreshablePageState>();
  final _notificationService = NotificationServiceFactory.SERVICE;

  Timer? _timer;
  User? _user;

  List<NotificationModel> _newNotifications = [];
  List<NotificationModel> _oldNotifications = [];

  Future<void> _resetUnread() async {
    await _notificationService.resetUnread();
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _refreshKey.currentState?.onRefresh();
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
    return Scaffold(
      appBar: ConnectAppBar(context: context, selectedIndex: 2),
      body: RefreshablePage(
        key: _refreshKey,
        onRefresh: () async {
          _notificationService.reset();
          _user = await ServiceFactory.userService.getProfile();
          if (_user == null) {
            // ignore: use_build_context_synchronously
            return [
              SizedBox(height: (MediaQuery.of(context).size.height / 2) - 30,),
              const Center(
                child: Text("You need to login first"),
              )
            ];
          }

          _newNotifications = await _notificationService.getList(
                  queryParameters:
                      const NotificationQueryParameters(seen: false)) ??
              [];
          _oldNotifications = await _notificationService.getList(
                  queryParameters:
                      const NotificationQueryParameters(seen: true)) ??
              [];

          setState(() {});

          _resetUnread();

          return [
            if (_newNotifications.isNotEmpty) ...[
              const SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.symmetric(
                    // ignore: use_build_context_synchronously
                    horizontal: getResponsiveMarginWidth(context)),
                child: const Text("New notifications",
                    style: TextStyle(color: ThemeService.clubColor)),
              ),
              const SizedBox(height: 15),
            ],
            // ignore: use_build_context_synchronously
            ...withDividers(_newNotifications, context,
                (item, index) => NotificationWidget(notification: item)),
            if (_oldNotifications.isNotEmpty) ...[
              const SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.symmetric(
                    // ignore: use_build_context_synchronously
                    horizontal: getResponsiveMarginWidth(context)),
                child: const Text("Old notifications",
                    style: TextStyle(color: ThemeService.clubColor)),
              ),
              const SizedBox(height: 15),
            ],
            // ignore: use_build_context_synchronously
            ...withDividers(_oldNotifications, context,
                (item, index) => NotificationWidget(notification: item)),
          ];
        },
        onLoad: () async {
          if (!_notificationService.next()) return null;
          final user = await ServiceFactory.userService.getProfile();
          if (user == null) {
            // ignore: use_build_context_synchronously
            closePage(context);
            return null;
          }

          _oldNotifications += await _notificationService.getList(
                  queryParameters:
                      const NotificationQueryParameters(seen: true)) ??
              [];

          setState(() {});

          return [
            if (_newNotifications.isNotEmpty) ...[
              const SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.symmetric(
                    // ignore: use_build_context_synchronously
                    horizontal: getResponsiveMarginWidth(context)),
                child: const Text("New notifications",
                    style: TextStyle(color: ThemeService.clubColor)),
              ),
              const SizedBox(height: 15),
            ],
            // ignore: use_build_context_synchronously
            ...withDividers(_newNotifications, context,
                (item, index) => NotificationWidget(notification: item)),
            if (_oldNotifications.isNotEmpty) ...[
              const SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.symmetric(
                    // ignore: use_build_context_synchronously
                    horizontal: getResponsiveMarginWidth(context)),
                child: const Text("Old notifications",
                    style: TextStyle(color: ThemeService.clubColor)),
              ),
              const SizedBox(height: 15),
            ],
            // ignore: use_build_context_synchronously
            ...withDividers(_oldNotifications, context,
                (item, index) => NotificationWidget(notification: item)),
          ];
        },
      ),
    );
  }
}
