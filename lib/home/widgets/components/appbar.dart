import 'package:campus_connect_frontend/auth/auth.dart';
import 'package:campus_connect_frontend/home/home.dart';
import 'package:campus_connect_frontend/messaging/messaging.dart';
import 'package:campus_connect_frontend/notifications/notifications.dart';
import 'package:campus_connect_frontend/users/users.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppBarButton extends StatefulWidget {
  const AppBarButton(
      {super.key,
      required this.title,
      required this.icon,
      required this.selected});
  final String title;
  final IconData icon;
  final bool selected;

  @override
  State<AppBarButton> createState() => _AppBarButtonState();
}

class _AppBarButtonState extends State<AppBarButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: ThemeService.allAroundBorderRadius,
          color: widget.selected ? ThemeService.clubColor : null),
      margin: const EdgeInsets.all(7),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          /* Icon(widget.icon,
              color: widget.selected
                  ? ThemeService.onContrastColor
                  : ThemeService.secondaryText),
          const SizedBox(width: 10), */
          Text(
            widget.title,
            style: TextStyle(
                color: widget.selected
                    ? ThemeService.onContrastColor
                    : ThemeService.secondaryText),
          )
        ],
      ),
    );
  }
}

// ignore: non_constant_identifier_names
AppBar ConnectAppBar({int selectedIndex = 0, required BuildContext context}) {
  final notificationService = NotificationServiceFactory.SERVICE;
  final messagesService = MessageServiceFactory.SERVICE;

  return AppBar(
    elevation: 5,
    title: !kIsWeb
        ? null
        : Row(
            children: [
              Image.asset(
                'assets/logo.png',
                width: 30, // Adjust the width as needed
                height: 30, // Adjust the height as needed
              ),
              const SizedBox(
                  width: 8), // Add some spacing between the logo and title
              const Text(
                "CampusConnect",
                style: TextStyle(color: ThemeService.primaryText),
              ),
            ],
          ),
    centerTitle: false,
    actions: [
      GestureDetector(
        onTap: () async {
          closePage(context);
          launchPage(context, const HomeView());
        },
        child: AppBarButton(
            title: "Home", icon: Icons.home, selected: selectedIndex == 0),
      ),
      GestureDetector(
        onTap: () async {
          closePage(context);
          launchPage(context, const ChatsLobby());
        },
        child: ValueListenableBuilder(
            valueListenable: messagesService.getUnreadCount,
            builder: (context, value, _) => Stack(
                  children: [
                    if (value > 0)
                      Positioned(
                          left: 10,
                          top: 10,
                          child: Badge(label: Text(value.toString()))),
                    AppBarButton(
                        title: "Messages",
                        icon: Icons.message,
                        selected: selectedIndex == 1)
                  ],
                )),
      ),
      GestureDetector(
        onTap: () async {
          closePage(context);
          launchPage(context, const NotificationPage());
        },
        child: ValueListenableBuilder<int>(
            valueListenable: notificationService.getUnreadCount,
            builder: (context, value, _) => Stack(children: [
                  if (value > 0)
                    Positioned(
                        left: 10,
                        top: 10,
                        child: Badge(label: Text(value.toString()))),
                  AppBarButton(
                      title: "Notifications",
                      icon: Icons.notifications,
                      selected: selectedIndex == 2)
                ])),
      ),
      GestureDetector(
        onTap: () async {
          if (await APIAuthServiceFactory.SERVICE.isLogedIn) {
            // ignore: use_build_context_synchronously
            launchPage(context, const ProfilePage(myProfile: true));
          } else {
            // ignore: use_build_context_synchronously
            launchPage(context, const RegisterPage());
          }
        },
        child: AppBarButton(
            title: "Profile", icon: Icons.person, selected: selectedIndex == 3),
      )
    ],
    backgroundColor: Colors.white,
  );
}
