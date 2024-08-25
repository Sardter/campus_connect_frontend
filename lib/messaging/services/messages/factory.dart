import 'package:campus_connect_frontend/messaging/messaging.dart';
import 'package:campus_connect_frontend/utilities/services/service_factory.dart';

class MessageServiceFactory {
  static final MessageServiceFactory _factory =
      MessageServiceFactory._internal();
  factory MessageServiceFactory() {
    return _factory;
  }
  MessageServiceFactory._internal();

  // ignore: non_constant_identifier_names
  static final SERVICE = ServiceFactory.mode == ServiceFactoryMode.test
      ? MessageTestService()
      : MessageAPIService();
}
