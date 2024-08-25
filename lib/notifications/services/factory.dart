import 'package:campus_connect_frontend/notifications/services/services.dart';
import 'package:campus_connect_frontend/utilities/services/service_factory.dart';

class NotificationServiceFactory {
  static final NotificationServiceFactory _factory =
      NotificationServiceFactory._internal();
  factory NotificationServiceFactory() {
    return _factory;
  }
  NotificationServiceFactory._internal();

  // ignore: non_constant_identifier_names
  static final SERVICE = ServiceFactory.mode == ServiceFactoryMode.test
      ? NotificationTestService()
      : NotificationAPIService();
}
