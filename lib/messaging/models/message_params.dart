import 'package:campus_connect_frontend/messaging/models/message.dart';
import 'package:campus_connect_frontend/users/models/user.dart';
import 'package:campus_connect_frontend/utilities/filters/filters.dart';

class MessageQueryParameters extends QueryParameters<MessageModel> {
  final User? room;
  final bool? read;
  final bool? received;
  final String? order;

  const MessageQueryParameters({
    super.searchQuery,
    this.room,
    this.read,
    this.received,
    this.order = "-created_at",
    super.sorted = true,
  });

  @override
  List<String?> get fieldsToStr => [
        fieldStringify<User>(room, (field) => "other=${field.id}"),
        fieldStringify<bool>(read, (field) => "read=$field"),
        fieldStringify(order, (field) => "order_by=$field"),
        fieldStringify(received, (field) => "received=$field")
      ];
}
