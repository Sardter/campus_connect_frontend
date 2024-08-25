import 'package:campus_connect_frontend/notifications/notifications.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key, required this.notification});
  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: getResponsiveMarginWidth(context), vertical: 5),
      child: Row(
        children: [
          if (notification.image != null) ...[
            SocialUtilImageProvider(
                image: notification.image, defaultImage: null),
            const SizedBox(width: 10)
          ],
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notification.title,
                style: const TextStyle(fontSize: 15),
              ),
              if (notification.description != null)
                Text(notification.description!,
                    style: const TextStyle(color: ThemeService.secondaryText))
            ],
          )
        ],
      ),
    );
  }
}
