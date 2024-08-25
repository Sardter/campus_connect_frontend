import 'package:campus_connect_frontend/users/users.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as chat_ui;
import 'package:uuid/uuid.dart';

class MessageModel extends Model {
  final String content;
  final dynamic room;
  final User author;
  final DateTime dateTime;
  final bool read;

  const MessageModel({
    required super.id,
    required this.content,
    required this.room,
    required this.author,
    required this.read,
    required this.dateTime,
  });

  factory MessageModel.fromPartialText(
      chat_ui.PartialText text, dynamic room, User author) {
    return MessageModel(
        id: null,
        content: text.text,
        room: room,
        author: author,
        read: false,
        dateTime: DateTime.now());
  }

  MessageModel copyWith({bool? read}) {
    return MessageModel(
        id: id,
        content: content,
        room: room,
        author: author,
        read: read ?? this.read,
        dateTime: dateTime);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'receiver_id': room,
      'content': content
    };
  }

  chat_ui.Message get uiComponent => chat_ui.TextMessage(
      author: author.chatUIUser,
      id: const Uuid().v4(),
      text: content,
      status: read ? chat_ui.Status.seen : chat_ui.Status.sent,
      createdAt: dateTime.millisecondsSinceEpoch);
}
