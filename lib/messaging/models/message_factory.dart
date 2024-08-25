import 'package:campus_connect_frontend/messaging/messaging.dart';
import 'package:campus_connect_frontend/users/models/user_factory.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class MessageModelFactory extends ModelFactory<MessageModel> {
  @override
  MessageModel fromJson(Map<String, dynamic> json) {
    return MessageModel(
        id: json['id'],
        content: json['content'],
        room: json['receiver']['id'],
        author: UserFactory().fromJson(json['sender']),
        read: json['read'],
        dateTime: DateTime.tryParse(json['created_at'] ?? "") ?? DateTime.now());
  }
}
