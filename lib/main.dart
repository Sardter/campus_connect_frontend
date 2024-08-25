import 'package:campus_connect_frontend/home/home.dart';
import 'package:campus_connect_frontend/messaging/messaging.dart';
import 'package:campus_connect_frontend/notifications/notifications.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'utilities/factories/factories.dart';

void main() {
  initializeDateFormatting("tr_TR").then((_) => runApp(const MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();

    StorageServiceFactory.SERVICE.init();

    APIServiceFactory();
    StorageServiceFactory();
    APIAuthServiceFactory();

    APIAuthServiceFactory.SERVICE.init();

    NotificationServiceFactory();
    MessageServiceFactory();

    NotificationServiceFactory.SERVICE.startStream();
    MessageServiceFactory.SERVICE.startStream();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: const HomeView(),
      debugShowCheckedModeBanner: false,
    );
  }

  @override
  void dispose() {
    MessageServiceFactory.SERVICE.endStream();
    NotificationServiceFactory.SERVICE.endStream();
    super.dispose();
  }
}
