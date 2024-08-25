import 'package:campus_connect_frontend/utilities/utilities.dart';

class UserQueryParameters extends QueryParameters {
  final bool chat;

  const UserQueryParameters({super.searchQuery, this.chat = false});
  
  @override
  List<String?> get fieldsToStr => [
    fieldStringify(chat, (field) => "chat=$field")
  ];
}